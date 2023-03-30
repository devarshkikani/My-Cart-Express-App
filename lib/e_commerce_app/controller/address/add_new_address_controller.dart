import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddressController extends GetxController {
  RxString country = ''.obs;
  RxBool isHome = false.obs;
  RxBool isOffice = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeOffice = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();
}
