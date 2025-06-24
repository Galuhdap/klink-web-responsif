import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/user/controller/user_manajemen_controller.dart';
import 'package:klinik_web_responsif/presentations/user/tabel/list_admin_tabel.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:number_paginator/number_paginator.dart';

class WidgetValidasi extends StatelessWidget {
  const WidgetValidasi({
    super.key,
    required this.controller,
    required this.label,
    required this.data,
  });

  final UserManajemenController controller;
  final String label;
  final List<UserData> data;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTabelComponent(
        label: label,
        border: TableBorder.all(
          color: AppColors.colorBaseSecondary.withAlpha(50),
        ),
        sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
        sizeWidth: MediaQuery.of(context).size.width / 1,
        customContentPagination: controller.numberOfPage.value == 0
            ? Container()
            : Container(
                width: double.infinity,
                padding: AppSizes.onlyPadding(bottom: AppSizes.s50),
                child: Column(
                  children: [
                    Container(
                      //width: 400,
                      decoration: BoxDecoration(
                        color: AppColors.colorBaseWhite,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Obx(() {
                        return NumberPaginator(
                          numberPages: controller.numberOfPage.value,
                          onPageChange: (int index) {
                            final page = index + 1;

                            controller.getUser(
                                page: page, name: controller.name.value);
                          },
                          child: const SizedBox(
                            height: 48,
                            width: 300,
                            child: Row(
                              children: [
                                PrevButton(),
                                Expanded(
                                  child: NumberContent(),
                                ),
                                NextButton(),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
        customContent: Container(
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 15,
                spreadRadius: 0,
                color: AppColors.colorNeutrals300.withAlpha(40),
              ),
            ],
          ),
          child: SearchNewComponent(
            controller: controller.searchController,
            keyboardType: TextInputType.name,
            hintText: AppConstants.LABEL_CARI,
            suffixIcon: const Icon(
              Icons.search,
              color: AppColors.colorSecondary500,
            ),
            onChanged: (value) {
              final input = value.trim();

              String name = '';

              name = input.trim();
              controller.name.value = name;
              controller.getUser(
                name: name.isNotEmpty ? name : '',
              );
            },
          ),
        ),
        listColumns: getListAdminColumns(),
        listRows: getRowsAdmin(
          data: data,
          isLoading: controller.isLoading.value,
          context: context,
          controller: controller,
        ),
      ),
    );
  }
}