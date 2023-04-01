import 'package:my_cart_express/e_commerce_app/data/model/model.dart';
import 'package:my_cart_express/e_commerce_app/e_data/e_provider/api.dart';

class MyRepository {
  MyRepository({required this.apiClient});
  final MyApiClient apiClient;

  Future<List<MyModel>> getAll() {
    return apiClient.getAll();
  }

  Future<void> getId(String id) {
    return apiClient.getId(id);
  }
}
