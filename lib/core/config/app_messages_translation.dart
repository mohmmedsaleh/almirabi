import 'package:get/get_navigation/src/root/internacionalization.dart';
import '../utils/translations/ar.dart';
import '../utils/translations/en.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": ar,
        "en": en,
      };
}
