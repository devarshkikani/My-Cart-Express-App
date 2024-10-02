import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_model/drawer_end_details_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/close_drawer/end_drawer_details/end_drawer_details_controller.dart';

class ClosedrawerDesign extends StatefulWidget {
  final String drawerId;
  final String initalAmount;
  const ClosedrawerDesign(
      {super.key, required this.drawerId, required this.initalAmount});

  @override
  State<ClosedrawerDesign> createState() => _ClosedrawerDesignState();
}

class _ClosedrawerDesignState extends State<ClosedrawerDesign> {
  final EndDrawerDetailsController _ =
      Get.put<EndDrawerDetailsController>(EndDrawerDetailsController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _.drawerDetails(context, widget.drawerId, widget.initalAmount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'End Drawer Details',
        ),
      ),
      body: GetBuilder<EndDrawerDetailsController>(builder: (ctx) {
        return Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cash Drawer #${_.drawerDetailsData.value.drawerDetails != null ? _.drawerDetailsData.value.drawerDetails!.id : ""}',
                            style: mediumText14.copyWith(color: Colors.white),
                          ),
                          height5,
                          Text(
                            _.drawerDetailsData.value.branchName != null
                                ? _.drawerDetailsData.value.branchName!
                                : "",
                            style: mediumText14.copyWith(color: Colors.white),
                          ),
                          height5,
                          if (_.drawerDetailsData.value.drawerDetails != null)
                            Text(
                              'Started ${DateFormat('dd MMM yyyy HH:mm a').format(_.drawerDetailsData.value.drawerDetails!.insertTimestamp!)}',
                              style: regularText12.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                        ],
                      ),
                    ),
                    height10,
                    const Text(
                      'Total Cash Counted',
                    ),
                    height5,
                    textFormField(
                        hintText: '', controller: _.cashsummedController),
                    height10,
                    const Text(
                      'Total Card Receipt Summed',
                    ),
                    height5,
                    textFormField(
                        hintText: '',
                        controller: _.cardreceiptsummedController),
                    height10,
                    const Text('Bag #'),
                    height5,
                    textFormField(
                        hintText: 'Bag #', controller: _.bagHashController),
                    height10,
                    const Row(
                      children: [
                        Text(
                          'Bag Attachment File',
                          style: lightText14,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bag has file',
                                ),
                                Obx(() => Text(
                                      _.baghasImagePath.value != ''
                                          ? _.baghasImagePath.value
                                          : '(filename.txt)',
                                      style: lightText14.copyWith(
                                        color: primary,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: greyColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    selectFileType(context);
                                  },
                                  child: const Text(
                                    'select file...',
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    height10,
                    const Text('Verified By'),
                    height5,
                    Obx(
                      () => (_.drawerDetailsData.value.staffList != null)
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<StaffList>(
                                value: _.dropdownValue != null
                                    ? _.dropdownValue!.value
                                    : null,
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('Select'),
                                ),
                                underline: const SizedBox(),
                                items: _.drawerDetailsData.value.staffList!
                                    .map<DropdownMenuItem<StaffList>>(
                                        (StaffList value) {
                                  return DropdownMenuItem<StaffList>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        value.firstname.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (StaffList? newValue) {
                                  setState(() {
                                    _.dropdownValue = newValue!.obs;
                                  });
                                },
                              ),
                            )
                          : const SizedBox(),
                    ),
                    height10,
                    const Row(
                      children: [
                        Text(
                          'Verified Attachment File',
                          style: lightText14,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Verified By file',
                                ),
                                Obx(() => Text(
                                      _.varifiedByImagePath.value != ''
                                          ? _.varifiedByImagePath.value
                                          : '(filename.txt)',
                                      style: lightText14.copyWith(
                                        color: primary,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: greyColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    selectVerifiedFileType(context);
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'select file...',
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    height5,
                    Text(
                      'I will attest that sum of money is true to count and that if any irregularaties.I will be held accountable.',
                      style: lightText12.copyWith(fontWeight: FontWeight.w400),
                    ),
                    height10,
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: Size(Get.width, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_.bagHashController.text.isNotEmpty) {
                            if (_.dropdownValue != null) {
                              _.closedDrawerApi(
                                  context,
                                  _.bagHashController.text,
                                  _.dropdownValue!.value.userId.toString(),
                                  _.drawerDetailsData.value.drawerDetails!.id
                                      .toString(),
                                  _.cashsummedController.text,
                                  _.cardreceiptsummedController.text);
                            } else {
                              NetworkDio.showError(
                                  title: "Error",
                                  errorMessage:
                                      "Please enter verfied by staff id");
                            }
                          } else {
                            NetworkDio.showError(
                                title: "Error",
                                errorMessage: "Please enter Bag #");
                          }
                        },
                        child: const Text(
                          'Close Drawer',
                          style: TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void selectFileType(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                buttonStyle(
                    title: 'CHOOSE IMAGE FROM GALLERY',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result != null) {
                        _.baghasImagePath.value = result.path;
                      }
                    }),
                height10,
                buttonStyle(
                    title: 'TAKE A PHOTO',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (result != null) {
                        _.baghasImagePath.value = result.path;
                        setState(() {});
                      }
                    }),
                height10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                height20,
              ],
            ),
          ),
        );
      },
    );
  }

  void selectVerifiedFileType(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                buttonStyle(
                    title: 'CHOOSE IMAGE FROM GALLERY',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result != null) {
                        _.varifiedByImagePath.value = result.path;
                      }
                    }),
                height10,
                buttonStyle(
                    title: 'TAKE A PHOTO',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (result != null) {
                        _.varifiedByImagePath.value = result.path;
                        setState(() {});
                      }
                    }),
                height10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                height20,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttonStyle({required String title, required Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: whiteColor,
        textStyle: const TextStyle(color: blackColor),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: blackColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    );
  }
}
