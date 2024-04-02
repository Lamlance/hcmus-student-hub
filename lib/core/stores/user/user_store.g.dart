// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$selectedUserAtom =
      Atom(name: '_UserStore.selectedUser', context: context);

  @override
  UserData? get selectedUser {
    _$selectedUserAtom.reportRead();
    return super.selectedUser;
  }

  @override
  set selectedUser(UserData? value) {
    _$selectedUserAtom.reportWrite(value, super.selectedUser, () {
      super.selectedUser = value;
    });
  }

  late final _$selectedTypeAtom =
      Atom(name: '_UserStore.selectedType', context: context);

  @override
  AccountType? get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(AccountType? value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void setSelectedUser(UserData? user) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setSelectedUser');
    try {
      return super.setSelectedUser(user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedType(AccountType type) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setSelectedType');
    try {
      return super.setSelectedType(type);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedUser: ${selectedUser},
selectedType: ${selectedType}
    ''';
  }
}
