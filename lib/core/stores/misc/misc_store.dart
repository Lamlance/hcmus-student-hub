import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:mobx/mobx.dart';
part 'misc_store.g.dart';

class MiscStore = _MiscStore with _$MiscStore;

abstract class _MiscStore with Store {
  @observable
  bool isDarkTheme = true;

  @action
  changeTheme(bool isDark) {
    isDarkTheme = isDark;
  }
}
