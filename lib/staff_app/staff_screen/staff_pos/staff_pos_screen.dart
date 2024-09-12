import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_validator.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/login/login_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/customer_available_packages.dart';
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
                        child: _.drawerDetails != null
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
                      "#${_.drawerDetails!.value.id}",
                      style: mediumText18.copyWith(color: primary),
                    ),
                  ],
                ),
                height5,
                Text(
                  "Started ${_.drawerDetails!.value.drawerStartDate}",
                  style: regularText14.copyWith(fontWeight: FontWeight.w400),
                ),
                height5,
                Text(
                  _.drawerDetails!.value.posBranchName.toString(),
                  style: mediumText18,
                ),
              ],
            ),
          ),
        ),
        height10,
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