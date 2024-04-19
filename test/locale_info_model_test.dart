import 'package:test/test.dart';
import 'package:xlcdapp/src/models/locale_info_model.dart';
import 'package:xlcdapp/src/data/global_config.dart';

void main() {
  test('Test default locale name and store name', () {
    final locale = LocaleInfoModel();
    final localeName = locale.localeName;
    expect(localeName, equals(LOCALE_ZH_TW));

    final storeName = locale.storeName;
    expect(storeName, equals(JOYSTORE_NAME_ZH_TW));
  });

  test('Test LocaleInfoModel.getAppLocaleInfo()', () {
    final locale = LocaleInfoModel();
    final (localeName, storeName) = locale.getAppLocaleInfo();
    expect(localeName, equals(LOCALE_ZH_TW));
    expect(storeName, equals(JOYSTORE_NAME_ZH_TW));
  });

  test('Test LocaleInfoModel.setAppLocaleInfo()', () {
    var newTestRecords = <String, String>{
      'locale': LOCALE_ZH_CN,
      'store': JOYSTORE_NAME_ZH_CN,
    };

    final locale = LocaleInfoModel();

    locale.addListener(() {
      final (localeName, storeName) = locale.getAppLocaleInfo();
      // expect(localeName, isNot(equals(LOCALE_ZH_TW)));
      expect(localeName != LOCALE_ZH_TW, true);
      expect(storeName != JOYSTORE_NAME_ZH_TW, true);
    });

    locale.setAppLocaleInfo(newTestRecords);

    final (localeName1, storeName1) = locale.getAppLocaleInfo();
    expect(localeName1, equals(LOCALE_ZH_CN));
    expect(storeName1, equals(JOYSTORE_NAME_ZH_CN));
  });
}
