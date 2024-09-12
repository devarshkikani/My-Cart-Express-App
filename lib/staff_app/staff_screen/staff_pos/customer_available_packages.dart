import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/models/scanned_package_details.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

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
          BoxGridSection(
            incomeData: widget.data,
          ),
          const SizedBox(
            height: 20,
          ),
          TransactionSection(
            trasnsactioData: widget.data,
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

class BoxGridSection extends StatefulWidget {
  final ScanPosPackageData incomeData;
  const BoxGridSection({super.key, required this.incomeData});

  @override
  State<BoxGridSection> createState() => _BoxGridSectionState();
}

class _BoxGridSectionState extends State<BoxGridSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   controller.signInOnTap(
                      //     email: emailId.text.trim(),
                      //     password: password.text.trim(),
                      //     context: context,
                      //   );
                      // }
                    },
                    child: Text(
                      "₹ ${widget.incomeData.walletBalance}",
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
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   controller.signInOnTap(
                      //     email: emailId.text.trim(),
                      //     password: password.text.trim(),
                      //     context: context,
                      //   );
                      // }
                    },
                    child: Text(
                      "₹ ${widget.incomeData.bucksBalance}",
                      style: const TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Wrap(
      //   runSpacing: 10,
      //   spacing: 10,
      //   children: List.generate(
      //     data.length,
      //     (index) {
      //       return Container(
      //         width: MediaQuery.of(context).size.width * 0.27,
      //         height: 88,
      //         padding: const EdgeInsets.all(6),
      //         decoration: BoxDecoration(
      //           color: whiteColor,
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //         child: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 data[index].values.first,
      //                 style: const TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               const SizedBox(height: 5),
      //               Text(
      //                 data[index].keys.first,
      //                 textAlign: TextAlign.center,
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class TransactionSection extends StatefulWidget {
  final ScanPosPackageData trasnsactioData;
  const TransactionSection({super.key, required this.trasnsactioData});

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transaction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          bodyView(),

          // Row(
          //   children: [
          //     const Text('Available (1)'),
          //     const Spacer(),
          //     ElevatedButton(
          //       onPressed: () {},
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //       child: const Text('Override'),
          //     ),
          //   ],
          // ),

          height10,
          PaymentScreen(
            paymentData: widget.trasnsactioData,
          ),
          height10,
          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Pay Now')),
          ),
        ],
      ),
    );
  }

  Widget bodyView() {
    return SizedBox(
      child: ListView.builder(
        itemCount: widget.trasnsactioData.transactionList!.length,
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
                          .trasnsactioData.transactionList![i].shippingMcecode),
                  const Divider(),
                  titleList(
                      title1: "Description",
                      title2: widget.trasnsactioData.transactionList![i]
                              .description ??
                          ""),
                  const Divider(),
                  titleList(
                      title1: "Weight",
                      title2:
                          widget.trasnsactioData.transactionList![i].weight),
                  const Divider(),
                  titleList(
                      title1: "Amount",
                      title2:
                          widget.trasnsactioData.transactionList![i].amount),
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

class PaymentScreen extends StatefulWidget {
  final ScanPosPackageData paymentData;
  const PaymentScreen({super.key, required this.paymentData});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  BankList? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Amount Tendered",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        buildPaymentField(context, "Cash (\$)", "Confirm Cash"),
        buildPaymentField(context, "Card (\$)", "Confirm Card"),
        buildPaymentField(context, "Ewallet (\$)", "Confirm Ewallet"),
        buildPaymentField(context, "Bucks", "Confirm Bucks"),
        buildPaymentField(context, "type Ewallet", "type Bucks"),
        buildPaymentFieldwithDropDown(context, "type Cash", "type Bucks"),
        // const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: textFormField(hintText: 'Invoice #'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "Change Due (\$)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
          buildPaymentField(context, "type Ewallet", "Ewallet Change"),
        // buildChangeDueField(context, "Cash Change"),
        const SizedBox(height: 16),
        // buildChangeDueField(context, "Ewallet Change"),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Handle add to ewallet logic
              },
              child: const Text("Add to Ewallet"),
            ),
          ),
        ),
      ],
    );
  }

  // Reusable widget for payment input fields
  Widget buildPaymentField(
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
              child: textFormField(hintText: confirmLabel),
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
  Widget buildChangeDueField(BuildContext context, String label) {
    return Row(
      children: [
        Expanded(
          child: textFormField(hintText: label),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}