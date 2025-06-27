import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/lib/message_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/del_antrian_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_archive_queue_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_statistic_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/put_antrian_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  final PasienRepository pasienRepository = locator();

  RxList<AntrianData> antrianPasienList = <AntrianData>[].obs;
  RxList<AntrianData> finishedPatients = <AntrianData>[].obs;
  Rx<PutAntrianPasienResponse?> putPasiens =
      Rx<PutAntrianPasienResponse?>(null);
  Rx<MessageResponse?> messageResponse = Rx<MessageResponse?>(null);
  Rx<DelAntrianResponse?> delAntrian = Rx<DelAntrianResponse?>(null);
  Rx<GetStatisticPasienResponse?> totalPasien =
      Rx<GetStatisticPasienResponse?>(null);
  Rx<GetArchiveQueueResponse?> archiveQueue =
      Rx<GetArchiveQueueResponse?>(null);
  RxList<AntrianData> processingPatients = <AntrianData>[].obs;
  RxList<AntrianData> takeMedicinePatients = <AntrianData>[].obs;
  RxList<AntrianData> waitingPatients = <AntrianData>[].obs;

  final searchController = TextEditingController();
  final searchControllerFinished = TextEditingController();
  final nameQueueController = TextEditingController();
  final nameQueueFinishedController = TextEditingController();
  final noQueueController = TextEditingController();
  final noQueueFinishedController = TextEditingController();
  final noRmeController = TextEditingController();
  final noRmeFinishedController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingFinished = false.obs;
  RxBool isLoadingTotal = false.obs;
  RxBool isPutLoading = false.obs;
  RxBool isDelLoading = false.obs;
  RxBool isLoadingArchiveQueue = false.obs;
  RxBool isLoadingGetAntrian = false.obs;
  RxString role = ''.obs;
  RxInt numberOfPage = 1.obs;
  RxInt numberOfPageGetAntrian = 1.obs;
  RxInt numberOfPageFinished = 1.obs;
  RxInt waitingTimeSecondss = 0.obs;
  RxBool queueActive = false.obs;

  RxBool timeActive = false.obs;

  RxInt waitingTime = 0.obs;
  RxInt waitingTimeDate = 0.obs;
  RxString waitingTimeFormated = ''.obs;
  //CountdownController _controller = CountdownController();

  final currentQueue = 0.obs;
  late IO.Socket socket;
  //Timer? _countdownTimer;

  RxString connectionStatus = 'Tidak Terhubung'.obs;
  final connectionColor = Rx<Color>(Colors.orange);

  @override
  void onInit() {
    super.onInit();
    connectSocket();
    getStatisticTotalPasien();
    getRole();
    getAntrianPasien();
    getAntrianPasienFinished();
    // getAntrianPasienFinished();
  }

  //SOCET.IO
  void connectSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      connectionStatus.value = 'Terhubung';
      connectionColor.value = Colors.green;
      getAntrianPasien();
      getAntrianPasienFinished();
    });

    socket.onDisconnect((_) {
      connectionStatus.value = 'Terputus';
      connectionColor.value = Colors.red;
    });

    socket.onConnectError((error) {
      connectionStatus.value = 'Gagal Terhubung';
      connectionColor.value = Colors.red;
    });

    socket.on("queue:status", (data) {
      queueActive.value = data['active'];
      antrianPasienList.refresh();
      finishedPatients.refresh();
    });

    socket.on("queue:status-change", (updatedItem) {
      final index =
          antrianPasienList.indexWhere((e) => e.id == updatedItem['id']);
      if (index != -1) {
        antrianPasienList[index].status = updatedItem['status'];
        antrianPasienList.refresh();
      } else {
        getAntrianPasien();
      }
    });

    // socket.on('queue:countdown', (data) {
    //   final itemIndex =
    //       antrianPasienList.indexWhere((item) => item.id == data['id']);
    //   if (itemIndex != -1) {
    //     antrianPasienList[itemIndex].waitingTimeSeconds =
    //         data['waitingTimeSeconds'];
    //     antrianPasienList[itemIndex].waitingTimeFormatted =
    //         data['waitingTimeFormatted'];
    //     antrianPasienList.refresh();
    //   }
    // });

    socket.on('queue:cleared', (_) => antrianPasienList.clear());

    socket.on('queue:new-entry', (newEntry) {
      final newAntrian = AntrianData.fromJson(newEntry);
      antrianPasienList.add(newAntrian);
      antrianPasienList.sort((a, b) =>
          int.parse(a.nomerAntrian).compareTo(int.parse(b.nomerAntrian)));
      antrianPasienList.refresh();
    });
  }

  Future<void> updateStatusQueue(String id, String newStatus) async {
    isPutLoading.value = true;
    try {
      print('Update queue...');
      await Future.delayed(Duration(seconds: 3));
      await Dio().patch(
        'http://localhost:3000/api/v1/queue/status/${id}',
        data: {"status": newStatus},
      );

      isPutLoading.value = false;
      Get.back();
    } catch (e) {
      print('Error starting queue: $e');
      isPutLoading.value = false;
    }
  }

  Future<void> startQueue() async {
    try {
      print('Starting queue...');
      await Dio().post(
        'http://localhost:3000/api/v1/queue/start',
      );
    } catch (e) {
      print('Error starting queue: $e');
    }
  }

  Future<void> stopQueue() async {
    try {
      print('Starting queue...');
      await Dio().post(
        'http://localhost:3000/api/v1/queue/stop',
      );
    } catch (e) {
      print('Error starting queue: $e');
    }
  }

  Future<void> resumeQueue() async {
    try {
      print('Starting queue...');
      await Dio().post(
        'http://localhost:3000/api/v1/queue/resume',
      );
    } catch (e) {
      print('Error starting queue: $e');
    }
  }

  Future<void> clearQueue() async {
    isLoading.value = true;
    try {
      print('Starting queue...');
      await Dio().delete(
        'http://localhost:3000/api/v1/queue/clear',
      );
      antrianPasienList.refresh();
      isLoading.value = false;
    } catch (e) {
      print('Error starting queue: $e');
      isLoading.value = false;
    }
  }

  void getRole() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    role.value = userData['role'];
  }

  bool isPasienSedangDalamAntrian(String idPasien) {
    final existing = antrianPasienList.where((item) =>
        item.idPasien == idPasien && item.status.toUpperCase() != 'FINISHED');
    getAntrianPasien();
    return existing.isNotEmpty;
  }

  Future<void> getAntrianPasien({
    int page = 1,
    int limit = 10,
    String name = '',
    String nomer_antrian = '',
    String no_rme = '',
  }) async {
    isLoadingGetAntrian.value = true;
    try {
      final response = await pasienRepository.getAntrianPasien(
          page: page,
          limit: limit,
          name: name,
          nomer_antrian: nomer_antrian,
          no_rme: no_rme);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          antrianPasienList.clear();
          final allData = response.data.data;

          if (role == 'DOKTER') {
            final processingOnly = allData
                .where((item) => item.status == "PROCESSING")
                .toList()
              ..sort((a, b) => int.parse(a.nomerAntrian)
                  .compareTo(int.parse(b.nomerAntrian)));

            antrianPasienList.addAll(processingOnly);
            numberOfPage.value = response.data.pagination.totalPages;
            // processingPatients.value = processingOnly;
            // waitingPatients.clear();
          } else if (role == 'APOTEKER') {
            final processingOnly = allData
                .where((item) => item.status == "TAKE_MEDICINE")
                .toList()
              ..sort((a, b) => int.parse(a.nomerAntrian)
                  .compareTo(int.parse(b.nomerAntrian)));

            antrianPasienList.addAll(processingOnly);
            numberOfPage.value = response.data.pagination.totalPages;
            // takeMedicinePatients.value = processingOnly;

            // waitingPatients.clear();
          } else {
            final statusOrder = {
              'WAITING': 0,
              'PROCESSING': 1,
              'TAKE_MEDICINE': 2,
              'PENDING': 3,
              'CANCELLED': 4,
            };
            final sortedData = allData
                .where((item) =>
                    statusOrder.containsKey(item.status.toUpperCase()))
                .toList()
              ..sort((a, b) {
                final aStatusOrder = statusOrder[a.status.toUpperCase()] ?? 999;
                final bStatusOrder = statusOrder[b.status.toUpperCase()] ?? 999;

                if (aStatusOrder != bStatusOrder) {
                  return aStatusOrder.compareTo(bStatusOrder);
                }

                return int.parse(a.nomerAntrian)
                    .compareTo(int.parse(b.nomerAntrian));
              });

            antrianPasienList.addAll(sortedData);
            numberOfPageGetAntrian.value = response.data.pagination.totalPages;
          }
        },
      );
      isLoadingGetAntrian.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingGetAntrian.value = false;
    }
  }

  Future<void> getAntrianPasienFinished({
    int page = 1,
    int limit = 10,
    String name = '',
    String nomer_antrian = '',
    String no_rme = '',
  }) async {
    isLoadingFinished.value = true;
    try {
      final response = await pasienRepository.getAntrianPasienFinished(
          page: page,
          limit: limit,
          name: name,
          nomer_antrian: nomer_antrian,
          no_rme: no_rme);

      response.fold((failure) {
        inspect(failure.code);
      }, (response) async {
        finishedPatients
          ..clear()
          ..addAll(response.data.data);

        numberOfPageFinished.value = response.data.pagination.totalPages;
      });
      isLoadingFinished.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingFinished.value = false;
    }
  }

  Future<void> archivedQueue() async {
    isLoadingArchiveQueue.value = true;
    try {
      final response = await pasienRepository.postArchiveQueue();

      response.fold((failure) async {
        inspect(failure.code);
        await Future.delayed(Duration(seconds: 3));

        getAntrianPasien();
        isLoadingArchiveQueue.value = false;
        Get.back();
        Get.snackbar(
          "Gagal Mengarsipkan Antrian",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }, (response) async {
        archiveQueue.value = response;
        await Future.delayed(Duration(seconds: 3));
        getAntrianPasien();
        Get.back();
        isLoadingArchiveQueue.value = false;
        Get.snackbar(
          "Antrian berhasil di hapus dan diarsipkan",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      });
    } catch (e) {
      print('e:$e');
      isLoadingArchiveQueue.value = false;
    }
  }

  Future<void> getAntrianProssesPasien({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await pasienRepository.getAntrianProsesPasien(
        page: page,
        limit: limit,
        search: search,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          antrianPasienList.clear();
          inspect(response.data.data);
          antrianPasienList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
          processingPatients.value = response.data.data
              .where((item) => item.status == "PROCESSING")
              .toList()
            ..sort((a, b) =>
                int.parse(a.nomerAntrian).compareTo(int.parse(b.nomerAntrian)));

          // Filter dan update data WAITING
          waitingPatients.value = response.data.data
              .where((item) => item.status == "WAITING")
              .toList()
            ..sort((a, b) =>
                int.parse(a.nomerAntrian).compareTo(int.parse(b.nomerAntrian)));
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> putAntrianPasien(String status, String id) async {
    isPutLoading.value = true;
    try {
      final response =
          await pasienRepository.putAntrianPasienSocket(status, id);
      response.fold(
        (failures) async {
          inspect(failures);
          isPutLoading.value = false;
          Get.back();
        },
        (response) async {
          messageResponse.value = response;

          // final updated = response.data;
          // final index = antrianPasienList.indexWhere((e) => e.id == id);
          // if (index != -1) {
          //   antrianPasienList[index].status = status;
          //   antrianPasienList.refresh();
          // } else {
          //   getAntrianPasien();
          // }
          isPutLoading.value = false;
          await Future.delayed(Duration(seconds: 3));
          Get.back();
        },
      );
    } catch (e) {
      print('e:$e');
      isPutLoading.value = false;
    }
  }

  Future<void> delAntrianPasien(String id) async {
    isDelLoading.value = true;
    try {
      final response = await pasienRepository.delAntrianId(id);

      response.fold(
        (failures) async {
          inspect(failures);
          await Future.delayed(Duration(seconds: 3));

          isDelLoading.value = false;
          Get.back();
        },
        (response) async {
          inspect(response.data);
          delAntrian.value = response;
          await Future.delayed(Duration(seconds: 3));
          getAntrianPasien();

          isDelLoading.value = false;
          Get.back();
        },
      );
    } catch (e) {
      print('e:$e');
      isDelLoading.value = false;
    }
  }

  Future<void> getStatisticTotalPasien() async {
    isLoadingTotal.value = true;
    try {
      final response = await pasienRepository.getStatisticTotalPasien();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          totalPasien.value = response;
        },
      );
      isLoadingTotal.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingTotal.value = false;
    }
  }
}
