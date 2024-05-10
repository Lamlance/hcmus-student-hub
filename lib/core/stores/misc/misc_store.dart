import 'package:mobx/mobx.dart';
part 'misc_store.g.dart';

class MiscStore = _MiscStore with _$MiscStore;

abstract class _MiscStore with Store {
  @observable
  bool isDarkTheme = true;

  @observable
  bool isEnglish = true;

  @action
  changeTheme(bool isDark) {
    isDarkTheme = isDark;
  }

  @action
  changeLanguage(bool isEng) {
    isEnglish = isEng;
  }
}
