import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/data/model/model.dart';
import 'package:my_cart_express/e_commerce_app/data/repository/posts_repository.dart';

class EDetailsController extends GetxController {
  EDetailsController({required this.repository});
  final MyRepository repository;

  final Rx<MyModel> _post = MyModel().obs;
  MyModel get post => _post.value;
  set post(MyModel value) => _post.value = value;

  void editar(MyModel myModel) {}

  void delete(int? id) {}
}
