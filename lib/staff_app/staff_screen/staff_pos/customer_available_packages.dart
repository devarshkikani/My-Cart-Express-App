import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';

import '../../../order_tracking_app/theme/colors.dart';
import '../../../order_tracking_app/theme/text_style.dart';

class CustomerAvailablePackages extends StatelessWidget {
  const CustomerAvailablePackages({super.key});

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
                  'Start Draw',
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
          const ProfileSection(),
          const SizedBox(
            height: 20,
          ),
          BoxGridSection(),
          const SizedBox(
            height: 20,
          ),
          const TransactionSection(),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

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
              'MCE80650 appteam s developer',
              style: boldText18,
            ),
            height5,
            const Text('Bronze Member'),
            height5,
            const Text('Total Packages: 34'),
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
                      '1',
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
            ElevatedButton(
              onPressed: () {},
              child: const Text('Toggle Packages'),
            ),
            height10,
            Text(
              'Branch: Kingston Hope Road',
              style: regularText18,
            ),
            height10,
            Text(
              'Email: mworksforu9@gmail.com',
              style: regularText18,
            ),
            height10,
            Text(
              'Phone #: (968) 988-8375',
              style: regularText18,
            ),
            height10,
            Text(
              'Birth Date #: ',
              style: regularText18,
            ),
            TextButton(
                onPressed: () {},
                child: const Text('See Full Customer Details')),
            const Text('Authorized Pickup'),
          ],
        ),
      ),
    );
  }
}

class BoxGridSection extends StatelessWidget {
  BoxGridSection({super.key});
  final List<Map<String, String>> data = [
    {
      'E-wallet Balance': '\$2501.00',
    },
    {
      'Bucks Balance': '\$0.00',
    },
    {
      'Shipment in Progress': '33',
    },
    {
      'Shipment For Pick Up': '0',
    },
    {
      'Shipment For Delivery': '0',
    },
    {
      'Completed Shipment': '0',
    },
    {
      'Refunded Shipment': '0',
    },
    {
      'Transactions': '0',
    },
    {
      'Orders': '0',
    },
    {
      'Attachments': '31',
    },
    {
      'Uploaded File': '22',
    },
    {
      'Notifications': '210',
    },
    {
      'Emails': '0',
    },
    {
      'Notes': '4',
    },
    {
      'Refunds': '0',
    },
    {
      'Incoming Call Logs': '0',
    },
    {
      'Outgoing Call Logs': '0',
    },
    {
      'Open Missing Package': '0',
    },
    {
      'Pending - Missing Package': '0',
    },
    {
      'Closed - Missing Package': '0',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: List.generate(
          data.length,
          (index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.27,
              height: 88,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[index].values.first,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data[index].keys.first,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  const TransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create a transaction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          height10,
          Row(
            children: [
              const Text('Available (1)'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Override'),
              ),
            ],
          ),
          height10,
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''PKG# : PKG740907''',
                  style: mediumText16.copyWith(
                    color: blackColor,
                  ),
                ),
                height5,
                Text(
                  '''Warehouse Binned: Hope Road WH''',
                  style: regularText14.copyWith(
                    color: primary,
                  ),
                ),
                height5,
                Text(
                  '''Due #: \$2050.00''',
                  style: regularText14,
                ),
                height5,
                Text(
                  '''Transaction: Waiting''',
                  overflow: TextOverflow.ellipsis,
                  style: regularText14,
                ),
              ],
            ),
          ),
          height10,
          ElevatedButton(onPressed: () {}, child: const Text('Pay Now')),
        ],
      ),
    );
  }
}
