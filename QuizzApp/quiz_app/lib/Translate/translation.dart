import 'package:get/get.dart';

class TranslationApp extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'titleCategory':'Category',
    },
    'vi_VN': {
      'titleCategory':'Danh muc',
    }
  };

}