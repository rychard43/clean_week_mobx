// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on SearchStoreBase, Store {
  final _$searchTextAtom = Atom(name: 'SearchStoreBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$stateAtom = Atom(name: 'SearchStoreBase.state');

  @override
  SearchState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$SearchStoreBaseActionController =
      ActionController(name: 'SearchStoreBase');

  @override
  dynamic setSearchText(String value) {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction(
        name: 'SearchStoreBase.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setState(SearchState value) {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction(
        name: 'SearchStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
state: ${state}
    ''';
  }
}
