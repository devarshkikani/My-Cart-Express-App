import 'package:my_cart_express/e_commerce_app/translations/en_US/en_us_translations.dart';
import 'package:my_cart_express/e_commerce_app/translations/es_MX/es_mx_translations.dart';
import 'package:my_cart_express/e_commerce_app/translations/pt_BR/pt_br_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations =
      <String, Map<String, String>>{
    'pt_BR': ptBR,
    'en_US': enUs,
    'es_mx': esMx
  };
}
