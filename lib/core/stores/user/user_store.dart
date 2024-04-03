import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  UserData? selectedUser;

  @observable
  String? token;

  @observable
  AccountType? selectedType;

  @action
  void setSelectedUser(UserData? user, {String? accessToken}) {
    selectedUser = user;
    token = accessToken;
  }

  @action
  void setSelectedType(AccountType type) {
    if (type == AccountType.none) {
      return;
    }
    selectedType = type;
  }
}
