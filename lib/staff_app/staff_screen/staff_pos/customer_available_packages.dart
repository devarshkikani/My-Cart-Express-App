// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/models/scanned_package_details.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:dio/dio.dart' as dio;
import '../../../order_tracking_app/theme/colors.dart';
import '../../../order_tracking_app/theme/text_style.dart';

class CustomerAvailablePackages extends StatefulWidget {
  final ScanPosPackageData data;
  const CustomerAvailablePackages({super.key, required this.data});

  @override
  State<CustomerAvailablePackages> createState() =>
      _CustomerAvailablePackagesState();
}

class _CustomerAvailablePackagesState extends State<CustomerAvailablePackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                // leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'Payment',
                ),
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
                  child: bodyView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileSection(
            profiledata: widget.data,
          ),
          const SizedBox(
            height: 20,
          ),
          // BoxGridSection(
          //   incomeData: widget.data,
          // ),

          PaymentScreen(
            paymentData: widget.data,
          ),
        ],
      ),
    );
  }
}

class ProfileSection extends StatefulWidget {
  final ScanPosPackageData profiledata;
  const ProfileSection({super.key, required this.profiledata});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                dummyProfileImage,
                height: 100,
                width: 100,
              ),
            ),
            height10,
            Text(
              widget.profiledata.customerDetails!.customerName.toString(),
              style: boldText18,
            ),
            height5,
            Text(
              widget.profiledata.customerDetails!.priceGroupName.toString(),
            ),
            height5,
            Text(
                'Total Packages: ${widget.profiledata.customerDetails!.totalPackages.toString()}'),
            const SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.profiledata.customerDetails!.shipmentsReady
                          .toString(),
                      style: boldText16.copyWith(
                        color: secondary,
                      ),
                    ),
                    Text(
                      'Shipment For Pick Up',
                      style: regularText14.copyWith(
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('Toggle Packages'),
            // ),
            height10,
            Text(
              'Branch: ${widget.profiledata.customerDetails!.branchName.toString()}',
              style: regularText18,
            ),
            height10,
            Text(
              'Email: ${widget.profiledata.customerDetails!.email.toString()}',
              style: regularText18,
            ),
            height10,
            Text(
              'Phone #: ${widget.profiledata.customerDetails!.phone.toString()}',
              style: regularText18,
            ),
            height10,
            Text(
              'Birth Date : ${widget.profiledata.customerDetails!.birthDate ?? ""}',
              style: regularText18,
            ),
            TextButton(
                onPressed: () {},
                child: const Text('See Full Customer Details')),
            Text(
                'Authorized Pickup : ${widget.profiledata.customerDetails!.authorizedPickup ?? ""}'),
          ],
        ),
      ),
    );
  }
}

// class BoxGridSection extends StatefulWidget {
//   final ScanPosPackageData incomeData;
//   const BoxGridSection({super.key, required this.incomeData});

//   @override
//   State<BoxGridSection> createState() => _BoxGridSectionState();
// }

// class _BoxGridSectionState extends State<BoxGridSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Payment',
//             style: mediumText16,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 children: [
//                   const Text('EWallet Balance'),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       maximumSize: Size(Get.width, 50),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(5),
//                         ),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "₹ ${widget.incomeData.walletBalance}",
//                       style: const TextStyle(
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   const Text('Bucks Balance'),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       maximumSize: Size(Get.width, 50),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(5),
//                         ),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "₹ ${widget.incomeData.bucksBalance}",
//                       style: const TextStyle(
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TransactionSection extends StatefulWidget {
//   final ScanPosPackageData trasnsactioData;
//   const TransactionSection({super.key, required this.trasnsactioData});

//   @override
//   State<TransactionSection> createState() => _TransactionSectionState();
// }

// class _TransactionSectionState extends State<TransactionSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Transaction',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

//           bodyView(),
//           height10,

//         ],
//       ),
//     );
//   }

//   Widget bodyView() {
//     return SizedBox(
//       child: ListView.builder(
//         itemCount: widget.trasnsactioData.transactionList!.length,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, i) {
//           return Card(
//             elevation: 5,
//             child: Container(
//               width: Get.width,
//               padding: const EdgeInsets.all(16),
//               margin: const EdgeInsets.only(bottom: 10),
//               decoration: BoxDecoration(
//                   color: greyColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   titleList(
//                       title1: "PKG#",
//                       title2: widget
//                           .trasnsactioData.transactionList![i].shippingMcecode),
//                   const Divider(),
//                   titleList(
//                       title1: "Description",
//                       title2: widget.trasnsactioData.transactionList![i]
//                               .description ??
//                           ""),
//                   const Divider(),
//                   titleList(
//                       title1: "Weight",
//                       title2:
//                           widget.trasnsactioData.transactionList![i].weight),
//                   const Divider(),
//                   titleList(
//                       title1: "Amount",
//                       title2:
//                           widget.trasnsactioData.transactionList![i].amount),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Row titleList({
//     title1,
//     title2,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           // width: 120,
//           child: Text(
//             title1,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         width10,
//         const Text(":"),
//         width5,
//         Expanded(
//           child: Text(title2,
//               textAlign: TextAlign.end,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               )),
//         ),
//       ],
//     );
//   }

// }

class PaymentScreen extends StatefulWidget {
  final ScanPosPackageData paymentData;
  const PaymentScreen({super.key, required this.paymentData});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  BankList? dropdownValue;
  bool ismoneyAddedinwallet = false;

  num? addedWalletamount;
  TextEditingController cashController = TextEditingController();
  TextEditingController confirmCashController = TextEditingController();
  TextEditingController typeCashController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController confirmCardController = TextEditingController();
  TextEditingController typeCardController = TextEditingController();
  TextEditingController bucksController = TextEditingController();
  TextEditingController confirmBucksController = TextEditingController();
  TextEditingController typeBucksController = TextEditingController();
  TextEditingController ewalletController = TextEditingController();
  TextEditingController confirmEwalletController = TextEditingController();
  TextEditingController typewalletController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController cashChangeController = TextEditingController();
  TextEditingController addEwalletController = TextEditingController();

  chargeDueCalculate() {
    if (widget.paymentData.bucksBalance == 0) {
      bucksController.text = widget.paymentData.bucksBalance.toString();
      confirmBucksController.text = widget.paymentData.bucksBalance.toString();
    }
    if (cashController.text.isNotEmpty || cardController.text.isNotEmpty) {
      cashChangeController.text = (double.parse(
                  widget.paymentData.transactionList!.first.amount.toString()) <
              (double.parse(cashController.text.isNotEmpty
                      ? cashController.text
                      : "0") +
                  double.parse(cardController.text.isNotEmpty
                      ? cardController.text
                      : "0")))
          ? ((double.parse(cashController.text.isNotEmpty
                          ? cashController.text
                          : "0") +
                      double.parse(cardController.text.isNotEmpty
                          ? cardController.text
                          : "0")) -
                  double.parse(
                      widget.paymentData.transactionList!.first.amount.toString()))
              .toString()
          : "0.00";

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Payment',
          style: mediumText16,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('EWallet Balance'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "₹ ${(widget.paymentData.walletBalance ?? 0) + (addedWalletamount ?? 0)}",
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text('Bucks Balance'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "₹ ${widget.paymentData.bucksBalance}",
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Transaction',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        bodyView(),
        height20,
        const Text(
          "Amount Tendered",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          "Cash",
          style: regularText16,
        ),
        const SizedBox(
          height: 4,
        ),
        buildPaymentField(
          context: context,
          label: "Cash (\$)",
          confirmLabel: "Confirm Cash",
          type: 'type Cash',
          labelController: cashController,
          confirmLabelController: confirmCashController,
          typeController: typeCashController,
        ),
        if (cashController.text.isNotEmpty &&
            confirmCashController.text.isNotEmpty &&
            confirmCashController.text != cashController.text)
          Text(
            'Cash and Confirm Cash amount is not match.',
            style: regularText14.copyWith(color: Colors.red),
          ),
        if (cashController.text.isNotEmpty &&
            confirmCashController.text.isNotEmpty &&
            confirmCashController.text != cashController.text)
          const SizedBox(
            height: 10,
          ),
        Text(
          "Card",
          style: regularText16,
        ),
        const SizedBox(
          height: 4,
        ),
        buildPaymentField(
            context: context,
            label: "Card (\$)",
            confirmLabel: "Confirm Card",
            type: 'type Card',
            labelController: cardController,
            confirmLabelController: confirmCardController,
            typeController: typeCardController),
        if (cardController.text.isNotEmpty &&
            confirmCardController.text.isNotEmpty &&
            confirmCardController.text != cardController.text)
          Text(
            'Card and Confirm Card amount is not match.',
            style: regularText14.copyWith(color: Colors.red),
          ),
        if (cardController.text.isNotEmpty &&
            confirmCardController.text.isNotEmpty &&
            confirmCardController.text != cardController.text)
          const SizedBox(
            height: 10,
          ),
        Row(
          children: [
            Expanded(
              child: textFormField(
                  hintText: 'Invoice #', controller: invoiceController),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Bucks",
          style: regularText16,
        ),
        const SizedBox(
          height: 4,
        ),
        buildPaymentField(
            context: context,
            label: "Bucks (\$)",
            readOnly: widget.paymentData.bucksBalance == 0 ? true : null,
            confirmLabel: "Confirm Bucks",
            type: 'type Bucks',
            labelController: bucksController,
            confirmLabelController: confirmBucksController,
            typeController: typeBucksController),
        if (bucksController.text.isNotEmpty &&
            confirmBucksController.text.isNotEmpty &&
            confirmBucksController.text != bucksController.text)
          Text(
            'Bucks and Confirm Bucks amount is not match.',
            style: regularText14.copyWith(color: Colors.red),
          ),
        if (bucksController.text.isNotEmpty &&
            confirmBucksController.text.isNotEmpty &&
            confirmBucksController.text != bucksController.text)
          const SizedBox(
            height: 10,
          ),
        Text(
          "Ewallet",
          style: regularText16,
        ),
        const SizedBox(
          height: 4,
        ),
        buildPaymentField(
            context: context,
            label: "Ewallet (\$)",
            confirmLabel: "Confirm Ewallet",
            type: 'type Ewallet',
            labelController: ewalletController,
            confirmLabelController: confirmEwalletController,
            typeController: typewalletController),
        if (ewalletController.text.isNotEmpty &&
            confirmEwalletController.text.isNotEmpty &&
            confirmEwalletController.text != ewalletController.text)
          Text(
            'Ewallet and Ewallet Bucks amount is not match.',
            style: regularText14.copyWith(color: Colors.red),
          ),
        if (ewalletController.text.isNotEmpty &&
            confirmEwalletController.text.isNotEmpty &&
            confirmEwalletController.text != ewalletController.text)
          const SizedBox(
            height: 10,
          ),
        const SizedBox(height: 24),
        const Text(
          "Change Due (\$)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        buildChangeDueField(
            context: context,
            label: "Due Amount",
            labelcontroller: cashChangeController,
            labelcontroller2: addEwalletController,
            labal2: "Add Ewallet Amount"),
        const SizedBox(height: 10),
        if (ismoneyAddedinwallet == false)
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  addEwalletBalance();
                },
                child: const Text("Add to Ewallet"),
              ),
            ),
          ),
        height20,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                // completeTranscation(context);
                completeTransaction(context: context);
              },
              child: const Text('Pay Now')),
        ),
      ],
    );
  }

  Future<void> addEwalletBalance() async {
    final data = dio.FormData.fromMap({
      'customer_id': widget.paymentData.customerDetails!.customerId.toString(),
      'ewallet_amount': addEwalletController.text,
      'trans_type': 1,
      'pos_transaction_id':
          widget.paymentData.transactionList!.first.posTransactionId.toString(),
      'type': "json",
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.addamounttoWallet,
      data: data,
    );

    if (response != null) {
      ismoneyAddedinwallet = true;
      addedWalletamount = num.parse(addEwalletController.text);
      cashChangeController.clear();
      addEwalletController.clear();
      NetworkDio.showSuccess(
          title: 'Success', sucessMessage: response['message']);
    } else {
      NetworkDio.showError(title: 'Error', errorMessage: response!['message']);
    }

    setState(() {});
  }

  Future<void> completeTransaction({
    required BuildContext context,
  }) async {
    if (cashController.text.isNotEmpty || (cardController.text.isNotEmpty)) {
      final data = dio.FormData.fromMap({
        "pos_transaction_id": widget
            .paymentData.transactionList!.first.posTransactionId
            .toString(),
        "customer_id":
            widget.paymentData.customerDetails!.customerId.toString(),
        "amount": widget.paymentData.transactionList!.first.amount.toString(),
        "payment_cash_amount": cashController.text,
        "payment_card_amount": cardController.text,
        "payment_ewallet_amount": ewalletController.text,
        "payment_change_due_amount": (double.parse(widget
                    .paymentData.transactionList!.first.amount
                    .toString()) <
                (double.parse(cashController.text.isNotEmpty
                        ? cashController.text
                        : "0") +
                    double.parse(cardController.text.isNotEmpty
                        ? cardController.text
                        : "0")))
            ? ((double.parse(cashController.text.isNotEmpty
                            ? cashController.text
                            : "0") +
                        double.parse(cardController.text.isNotEmpty
                            ? cardController.text
                            : "0")) -
                    double.parse(
                        widget.paymentData.transactionList!.first.amount.toString()))
                .toString()
            : "0.00",
        "txt_payment_remaining": (double.parse(widget
                    .paymentData.transactionList!.first.amount
                    .toString()) <
                (double.parse(cashController.text.isNotEmpty
                        ? cashController.text
                        : "0") +
                    double.parse(cardController.text.isNotEmpty
                        ? cardController.text
                        : "0")))
            ? ((double.parse(cashController.text.isNotEmpty
                            ? cashController.text
                            : "0") +
                        double.parse(cardController.text.isNotEmpty
                            ? cardController.text
                            : "0")) -
                    double.parse(
                        widget.paymentData.transactionList!.first.amount.toString()))
                .toString()
            : "0.00",

        "txt_payment_add_to_ewallet": 0,
        "confirm_payment_card_bank":
            dropdownValue != null ? dropdownValue!.id : null, // id
        "confirm_payment_card_invoice": invoiceController.text,
        "usd_payment_cash_amount":
            widget.paymentData.transactionDetails!.cashUsd.toString(),
        "cash_usd_jmd":
            widget.paymentData.transactionDetails!.cashUsdJmd.toString(),
        "usd_payment_card_amount":
            widget.paymentData.transactionDetails!.cardUsd.toString(),
        'payment_bucks_amount': bucksController.text,
        "payment_transaction_total":
            widget.paymentData.transactionList!.first.amount.toString(),
      });
      Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        context: context,
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.completeTransction,
        data: data,
      );

      if (response != null && response['status'] == 200) {
        completeTranscationdialog(context);
      } else {}
      NetworkDio.showError(title: 'Error', errorMessage: response!['message']);
    } else {
      NetworkDio.showError(
          title: 'Error', errorMessage: 'Enter all mandatory fields');
    }
  }

  void completeTranscationdialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height15,
                  Image.asset(
                    verified,
                    height: 100,
                    width: 100,
                  ),
                  height10,
                  Text(
                    'Transaction Successful',
                    style: mediumText16,
                  ),
                  height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Done',
                        ),
                      ),
                    ],
                  ),
                  height10,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

// verified
  // Reusable widget for payment input fields
  Widget buildPaymentField({
    required BuildContext context,
    required String label,
    required String confirmLabel,
    required String type,
    required TextEditingController labelController,
    required TextEditingController confirmLabelController,
    required TextEditingController typeController,
    bool? readOnly,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: textFormField(
                  hintText: label,
                  readOnly: readOnly,
                  onChanged: (val) {
                    ismoneyAddedinwallet = false;
                    chargeDueCalculate();
                    setState(() {});
                  },
                  controller: labelController),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: textFormField(
                  hintText: confirmLabel,
                  readOnly: readOnly,
                  onChanged: (val) {
                    ismoneyAddedinwallet = false;
                    chargeDueCalculate();
                    setState(() {});
                  },
                  controller: confirmLabelController),
            ),
            const SizedBox(width: 10),
            (type != 'type Card')
                ? Expanded(
                    child: textFormField(
                        hintText: type, controller: typeController),
                  )
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<BankList>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Select'),
                        ),
                        underline: const SizedBox(),
                        items: widget.paymentData.bankList!
                            .map<DropdownMenuItem<BankList>>((BankList value) {
                          return DropdownMenuItem<BankList>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                value.name.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (BankList? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildPaymentFieldwithDropDown(
      BuildContext context, String label, String confirmLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: textFormField(hintText: label),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<BankList>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Select'),
                  ),
                  underline: const SizedBox(),
                  items: widget.paymentData.bankList!
                      .map<DropdownMenuItem<BankList>>((BankList value) {
                    return DropdownMenuItem<BankList>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(value.branch.toString()),
                      ),
                    );
                  }).toList(),
                  onChanged: (BankList? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Reusable widget for Change Due section
  Widget buildChangeDueField(
      {required BuildContext context,
      required TextEditingController labelcontroller,
      required String label,
      required TextEditingController labelcontroller2,
      required String labal2}) {
    return Row(
      children: [
        Expanded(
          child: textFormField(hintText: label, controller: labelcontroller),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: textFormField(hintText: labal2, controller: labelcontroller2),
        ),
      ],
    );
  }

  Widget bodyView() {
    return SizedBox(
      child: ListView.builder(
        itemCount: widget.paymentData.transactionList!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Card(
            elevation: 5,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleList(
                      title1: "PKG#",
                      title2: widget
                          .paymentData.transactionList![i].shippingMcecode),
                  const Divider(),
                  titleList(
                      title1: "Description",
                      title2:
                          widget.paymentData.transactionList![i].description ??
                              ""),
                  const Divider(),
                  titleList(
                      title1: "Weight",
                      title2: widget.paymentData.transactionList![i].weight),
                  const Divider(),
                  titleList(
                      title1: "Amount",
                      title2: widget.paymentData.transactionList![i].amount),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row titleList({
    title1,
    title2,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // width: 120,
          child: Text(
            title1,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        width10,
        const Text(":"),
        width5,
        Expanded(
          child: Text(title2,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
        ),
      ],
    );
  }
}
