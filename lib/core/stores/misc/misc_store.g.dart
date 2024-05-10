// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MiscStore on _MiscStore, Store {
  late final _$isDarkThemeAtom =
      Atom(name: '_MiscStore.isDarkTheme', context: context);

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  late final _$isEnglishAtom =
      Atom(name: '_MiscStore.isEnglish', context: context);

  @override
  bool get isEnglish {
    _$isEnglishAtom.reportRead();
    return super.isEnglish;
  }

  @override
  set isEnglish(bool value) {
    _$isEnglishAtom.reportWrite(value, super.isEnglish, () {
      super.isEnglish = value;
    });
  }

  late final _$_MiscStoreActionController =
      ActionController(name: '_MiscStore', context: context);

  @override
  dynamic changeTheme(bool isDark) {
    final _$actionInfo = _$_MiscStoreActionController.startAction(
        name: '_MiscStore.changeTheme');
    try {
      return super.changeTheme(isDark);
    } finally {
      _$_MiscStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLanguage(bool isEng) {
    final _$actionInfo = _$_MiscStoreActionController.startAction(
        name: '_MiscStore.changeLanguage');
    try {
      return super.changeLanguage(isEng);
    } finally {
      _$_MiscStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme},
isEnglish: ${isEnglish}
    ''';
  }
}
