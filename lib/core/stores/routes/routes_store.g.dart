// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoutesStore on _RoutesStore, Store {
  late final _$currentIdxAtom =
      Atom(name: '_RoutesStore.currentIdx', context: context);

  @override
  int get currentIdx {
    _$currentIdxAtom.reportRead();
    return super.currentIdx;
  }

  @override
  set currentIdx(int value) {
    _$currentIdxAtom.reportWrite(value, super.currentIdx, () {
      super.currentIdx = value;
    });
  }

  late final _$_RoutesStoreActionController =
      ActionController(name: '_RoutesStore', context: context);

  @override
  void changeRouteIndex(int idx) {
    final _$actionInfo = _$_RoutesStoreActionController.startAction(
        name: '_RoutesStore.changeRouteIndex');
    try {
      return super.changeRouteIndex(idx);
    } finally {
      _$_RoutesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIdx: ${currentIdx}
    ''';
  }
}
