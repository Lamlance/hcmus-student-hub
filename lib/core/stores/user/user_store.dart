import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  UserData? selectedUser;

  @action
  void setSelectedUser(UserData user) {
    selectedUser = user;
  }
}
