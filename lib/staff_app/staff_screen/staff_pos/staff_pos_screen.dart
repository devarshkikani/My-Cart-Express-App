import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_validator.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/staff_app/staff_model/drawer_end_details_model.dart';
import 'package:my_cart_express/staff_app/staff_model/last_day_drawer_status_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/close_drawer/drawer_details/drawer_details_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/close_drawer/end_drawer_details/end_drawer_details_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_customer_pos_scanner.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_pos_controller.dart';

class StaffPosScreen extends StatefulWidget {
  const StaffPosScreen({super.key});

  @override
  State<StaffPosScreen> createState() => _StaffPosScreenState();
}

class _StaffPosScreenState extends State<StaffPosScreen> {
  GetStorage box = GetStorage();
  final StaffPosController _ =
      Get.put<StaffPosController>(StaffPosController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAmountReturned = false;

  StaffList? dropdownValue;

  @override
  void initState() {
    _.getDrawerStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StaffPosController>(
        init: StaffPosController(),
        builder: (ctx) {
          // _.getDrawerStatus(context);
          // _.getBranches(context);

          return Container(
            width: Get.height,
            color: primary,
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppBar(
                      leading: const SizedBox(),
                      centerTitle: true,
                      elevation: 0.0,
                      title: const Text(
                        'Customer POS',
                        style: TextStyle(color: whiteColor),
                      ),
                      // actions: [
                      //   InkWell(
                      //     onTap: () {
                      //       box.write(EStorageKey.eIsLogedIn, false);

                      //       Get.offAll(
                      //         () => LoginScreen(),
                      //       );
                      //     },
                      //     child: const Padding(
                      //       padding: EdgeInsets.all(15),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Text(
                      //             "Logout",
                      //             style: TextStyle(color: whiteColor),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios_rounded,
                      //             size: 18,
                      //             color: whiteColor,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ],
                    ),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: offWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: (_.drawerDetails != null ||
                                _.lastDayDrawerDetails != null)
                            ? posDetailsView()
                            : bodyView(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget posDetailsView() {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (_.lastDayDrawerDetails != null) {
                  showDialog(
                      context: context,
                      useSafeArea: false,
                      builder: (context) {
                        return customDialog(_.lastDayDrawerDetails!.value);
                      }).then((value) => {_.getDrawerStatus(context)});
                } else {
                  Get.to(() => const DrawerDetailsScreen());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Drawer ',
                        style: mediumText18,
                      ),
                      Text(
                        "#${_.lastDayDrawerDetails != null ? _.lastDayDrawerDetails!.value.id : _.drawerDetails!.value.id}",
                        style: mediumText18.copyWith(color: primary),
                      ),
                    ],
                  ),
                  height5,
                  Text(
                    "Started - ${_.lastDayDrawerDetails != null ? DateFormat('dd MMM yyyy HH:mm a').format(_.lastDayDrawerDetails!.value.insertTimestamp!) : _.drawerDetails!.value.drawerStartDate}",
                    style: regularText14.copyWith(fontWeight: FontWeight.w400),
                  ),
                  height5,
                  if (_.drawerDetails != null)
                    Text(
                      _.drawerDetails!.value.posBranchName.toString(),
                      style: mediumText18,
                    ),
                ],
              ),
            ),
          ),
        ),
        height10,
        if (_.drawerDetails != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
              maximumSize: const Size(200, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            onPressed: () async {
              Get.to(() => const StaffCustomerPosScreen());
              // getScannerPackgeList(context, widget.binCode, scannedPkgId);
            },
            child: const Text(
              'Scan New Package',
              style: TextStyle(
                letterSpacing: 1,
              ),
            ),
          )
      ],
    );
  }

  customDialog(LastDayDrawerDetails data) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 240, 199, 196),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please close the last opened drawer.',
                      style: mediumText14.copyWith(color: Colors.brown),
                    ),
                    height5,
                    Text(
                      'Cash Drawer #${data.id}',
                      style: mediumText14.copyWith(color: Colors.brown),
                    ),
                    height5,
                    Text(
                      'Started ${DateFormat('dd MMM yyyy HH:mm a').format(data.insertTimestamp!)}',
                      style: regularText12.copyWith(color: Colors.brown),
                    ),
                  ],
                ),
              ),
              height10,
              Text(
                'Initial Amount Returned',
                style: mediumText16.copyWith(fontWeight: FontWeight.w500),
              ),
              height10,
              Text(
                'Starting Cash Returned?',
                style: regularText14.copyWith(fontWeight: FontWeight.w400),
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      isAmountReturned = true;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(
                          isAmountReturned == true
                              ? Icons.radio_button_checked
                              : Icons.circle_outlined,
                          color: isAmountReturned == true ? primary : null,
                        ),
                        width5,
                        const Text('Yes')
                      ],
                    ),
                  ),
                  width20,
                  InkWell(
                    onTap: () {
                      isAmountReturned = false;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(
                            isAmountReturned == false
                                ? Icons.radio_button_checked
                                : Icons.circle_outlined,
                            color: isAmountReturned == false ? primary : null),
                        width5,
                        const Text('No')
                      ],
                    ),
                  ),
                ],
              ),
              height10,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(Get.width, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(() => ClosedrawerDesign(
                        drawerId: data.id.toString(),
                        initalAmount:
                            (isAmountReturned == true ? 1 : 0).toString(),
                      ));
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
        Text(
          'Initial Amount',
          style: lightText18.copyWith(),
        ),
        height20,
        TextFormFieldWidget(
          hintText: '0.00',
          controller: _.initalAmount,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ],
          validator: (value) =>
              Validators.validateText(value, 'Enter Initial Amount'),
        ),
        height20,
        TextFormFieldWidget(
          labelText: 'Select Branch',
          controller: _.branchName,
          readOnly: true,
          onTap: () {
            selectBranch(context);
          },
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: primary,
          ),
          validator: (value) => Validators.validateText(value, 'Select Branch'),
        ),
        height20,
        Center(
          child: SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _.startDrawer(context, _.initalAmount.text,
                      _.staffBranches[_.branchIndex.value].branchId.toString());
                  // Get.to(() => const CustomerAvailablePackages());
                }
              },
              child: const Text('Save'),
            ),
          ),
        ),
      ],
    );
  }

  void selectBranch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.20,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int value) {
                    _.branchIndex.value = value;
                  },
                  children: List.generate(
                    _.staffBranches.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Text(
                              '${_.staffBranches[index].parishname} - ${_.staffBranches[index].branchCode}',
                              style: mediumText14.copyWith(
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    _.branchName.text =
                        '${_.staffBranches[_.branchIndex.value].parishname} - ${_.staffBranches[_.branchIndex.value].branchCode}';
                    _.branchId.value =
                        _.staffBranches[_.branchIndex.value].branchId ?? '0';
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }
}
