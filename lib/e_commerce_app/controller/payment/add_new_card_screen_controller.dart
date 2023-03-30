import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCardScreenController extends GetxController {
  RxString country = ''.obs;
  RxBool isSaved = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController validUntil = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController cardname = TextEditingController();
}
