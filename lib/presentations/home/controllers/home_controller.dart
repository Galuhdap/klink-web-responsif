import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/del_antrian_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';
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
  Rx<DelAntrianResponse?> delAntrian = Rx<DelAntrianResponse?>(null);
  Rx<GetStatisticPasienResponse?> totalPasien =
      Rx<GetStatisticPasienResponse?>(null);
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
  RxString role = ''.obs;
  RxInt numberOfPage = 1.obs;
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
    //connectSocket();
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
      inspect('Conext');
      connectionStatus.value = 'Terhubung';
      connectionColor.value = Colors.green;
      print('Connected to socket server');
      getAntrianPasien();
      getAntrianPasienFinished();
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
      connectionStatus.value = 'Terputus';
      connectionColor.value = Colors.red;
    });

    socket.onConnectError((error) {
      print('Socket connection error: $error');
      connectionStatus.value = 'Gagal Terhubung';
      connectionColor.value = Colors.red;
    });

    socket.on(
      "queue:status",
      (data) => {
        print("Queue status update: ${data}"),
        queueActive.value = data['active'],
        antrianPasienList.refresh(),
        finishedPatients.refresh(),
      },
    );

    socket.on("queue:status-change", (updatedItem) {
      print("Queue status change ${updatedItem}");
      final itemIndex =
          antrianPasienList.indexWhere((item) => item.id == updatedItem['id']);
      if (itemIndex != -1) {
        antrianPasienList[itemIndex].status = updatedItem['status'];
        antrianPasienList.refresh();
      }
    });

    socket.on('queue:countdown', (data) {
      final itemIndex =
          antrianPasienList.indexWhere((item) => item.id == data['id']);
      if (itemIndex != -1) {
        antrianPasienList[itemIndex].waitingTimeSeconds =
            data['waitingTimeSeconds'];
        antrianPasienList[itemIndex].waitingTimeFormatted =
            data['waitingTimeFormatted'];
        antrianPasienList.refresh();
      } else {
        print("Item not found in queue data");
      }
    });

    socket.on('queue:cleared', (_) {
      print('Queue cleared event received');
      antrianPasienList.clear();
    });

    socket.on('queue:new-entry', (newEntry) {
      print("New queue entry received: ${newEntry}");
      final newAntrian = AntrianData.fromJson(newEntry);
      antrianPasienList.add(newAntrian);
      antrianPasienList.sort((a, b) =>
          int.parse(a.nomerAntrian).compareTo(int.parse(b.nomerAntrian)));
      antrianPasienList.refresh();
    });
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

  Future<void> getAntrianPasien({
    int page = 1,
    int limit = 10,
    String name = '',
    String nomer_antrian = '',
    String no_rme = '',
  }) async {
    isLoading.value = true;
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
          final allData = response.data.data;

          if (role == 'DOKTER') {
            antrianPasienList.clear();

            numberOfPage.value = response.data.pagination.totalPages;
            final processingOnly = allData
                .where((item) => item.status == "PROCESSING")
                .toList()
              ..sort((a, b) => int.parse(a.nomerAntrian)
                  .compareTo(int.parse(b.nomerAntrian)));

            antrianPasienList.addAll(processingOnly);
            processingPatients.value = processingOnly;
            waitingPatients.clear();
          } else if (role == 'APOTEKER') {
            antrianPasienList.clear();

            numberOfPage.value = response.data.pagination.totalPages;

            final processingOnly = allData
                .where((item) => item.status == "TAKE_MEDICINE")
                .toList()
              ..sort((a, b) => int.parse(a.nomerAntrian)
                  .compareTo(int.parse(b.nomerAntrian)));

            // final takeMedicineOnly = allData
            //     .where((item) =>
            //         item.status == "TAKE_MEDICINE" || item.status == "FINISHED")
            //     .toList()
            //   ..sort((a, b) {
            //     // Prioritaskan TAKE_MEDICINE, letakkan FINISHED di bawah
            //     if (a.status == "FINISHED" && b.status != "FINISHED") return 1;
            //     if (a.status != "FINISHED" && b.status == "FINISHED") return -1;
            //     return int.parse(a.nomerAntrian)
            //         .compareTo(int.parse(b.nomerAntrian));
            //   });
            antrianPasienList.addAll(processingOnly);
            takeMedicinePatients.value = processingOnly;

            waitingPatients.clear();
          } else {
            final statusOrder = {
              'WAITING': 0,
              'PROCESSING': 1,
              'TAKE_MEDICINE': 2,
              'PENDING': 3,
              'CANCELLED': 4,
            };

// Ambil hanya yang bukan 'FINISHED' dan termasuk dalam statusOrder
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

            antrianPasienList
              ..clear()
              ..addAll(sortedData);
            numberOfPage.value = response.data.pagination.totalPages;
          }
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
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
      final response = await pasienRepository.putAntrianPasien(status, id);

      response.fold(
        (failures) async {
          inspect(failures);
          await Future.delayed(Duration(seconds: 3));

          isPutLoading.value = false;
          Get.back();
        },
        (response) async {
          inspect(response.data);
          putPasiens.value = response;
          await Future.delayed(Duration(seconds: 3));
          final itemIndex = antrianPasienList.indexWhere(
            (item) => item.id == id,
          );
          if (itemIndex != -1) {
            antrianPasienList[itemIndex].status = status;
            antrianPasienList.refresh();
          } else {
            getAntrianPasien();
          }

          isPutLoading.value = false;
          Get.back();
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
