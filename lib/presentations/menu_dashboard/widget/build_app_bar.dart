import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class BuildAppBar extends StatelessWidget {
  final String title;
  final bool withSearchInput;
  final TextEditingController? searchController;
  final void Function(String)? searchChanged;
  final String searchHint;
  final Widget? trailing;
  final bool isMake;
  const BuildAppBar({
    super.key,
    required this.title,
    this.withSearchInput = false,
    this.searchController,
    this.searchChanged,
    this.searchHint = 'Cari di sini',
    this.trailing,
    this.isMake = false,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Container(
            padding: const EdgeInsets.all(27),
            decoration: const BoxDecoration(
              color: AppColors.colorBaseWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 20 : 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                    Text(
                      'Senin, 12 Februari 2024',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 8 : 16,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(27),
            decoration: const BoxDecoration(
              color: AppColors.colorBaseWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20 : 25,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                      Text(
                        'Senin, 12 Februari 2024',
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 8 : 16,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                isMake
                    ? InkWell(
                        onTap: () {
                          showModalCenter(
                            context,
                            ListView(
                              // crossAxisAlignment:
                              //     CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Tambah Data',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.s16),
                                  ),
                                ),
                                AppSizes.s12.height,
                                Divider(),
                                InputDataComponent(
                                  label: 'Nama Pasien',
                                  hintText: 'Nama Pasien',
                                  controller: TextEditingController(),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jenis Kelamin',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                    AppSizes.s12.height,
                                    DropdownSearch<String>(
                                      items: (f, cs) => [
                                        "Laki-Laki",
                                        'Perempuan',
                                      ],
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? "Jenis Kelamin",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: selectedItem == null
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        );
                                      },
                                      popupProps: PopupProps.menu(
                                          disabledItemFn: (item) =>
                                              item == 'Item 3',
                                          fit: FlexFit.loose),
                                      onChanged: (String? selectedValue) {
                                        print("Selected: $selectedValue");
                                      },
                                    ),
                                    AppSizes.s12.height,
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tanggal Lahir',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                    AppSizes.s12.height,
                                    InkWell(
                                      onTap: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(2021, 7, 25),
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(2022),
                                        );
                                      },
                                      child: Container(
                                          padding: AppSizes.symmetricPadding(
                                              vertical: AppSizes.s5,
                                              horizontal: AppSizes.s20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  AppColors.colorSecondary400,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s4),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                weight: AppSizes.s20,
                                                size: AppSizes.s30,
                                                color:
                                                    AppColors.colorNeutrals100,
                                              ),
                                              AppSizes.s10.width,
                                              Text(
                                                '12/12/2020',
                                                style: Get.textTheme.bodySmall!
                                                    .copyWith(
                                                  fontSize: AppSizes.s14,
                                                  color: AppColors
                                                      .colorNeutrals400,
                                                ),
                                              ),
                                            ],
                                          ).paddingSymmetric(
                                              vertical: AppSizes.s5)),
                                    ),
                                    AppSizes.s12.height,
                                  ],
                                ),
                                InputDataComponent(
                                  label: 'Alamat',
                                  hintText: 'Alamat',
                                  controller: TextEditingController(),
                                ),
                                InputDataComponent(
                                  label: 'No Telpon',
                                  hintText: 'No Telpon',
                                  controller: TextEditingController(),
                                ),
                                InputDataComponent(
                                  label: 'NIK',
                                  hintText: 'NIK',
                                  controller: TextEditingController(),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Button.outlined(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          label: 'Batal'),
                                    ),
                                    AppSizes.s12.width,
                                    Flexible(
                                      child: Button.filled(
                                          onPressed: () {}, label: 'Simpan'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 134,
                          height: 41,
                          decoration: BoxDecoration(
                            color: AppColors.colorBasePrimary,
                            borderRadius: BorderRadius.circular(AppSizes.s4),
                          ),
                          child: Center(
                            child: Text(
                              'Daftar Pasien',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSizes.s16,
                                  color: AppColors.colorBaseWhite),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
  }
}
