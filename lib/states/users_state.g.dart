// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersState on _UsersState, Store {
  Computed<List<dynamic>>? _$peopleComputed;

  @override
  List<dynamic> get people =>
      (_$peopleComputed ??= Computed<List<dynamic>>(() => super.people,
              name: '_UsersState.people'))
          .value;

  late final _$usersAtom = Atom(name: '_UsersState.users', context: context);

  @override
  Map<String, dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(Map<String, dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$imagefileAtom =
      Atom(name: '_UsersState.imagefile', context: context);

  @override
  File? get imagefile {
    _$imagefileAtom.reportRead();
    return super.imagefile;
  }

  @override
  set imagefile(File? value) {
    _$imagefileAtom.reportWrite(value, super.imagefile, () {
      super.imagefile = value;
    });
  }

  late final _$_searchUserAtom =
      Atom(name: '_UsersState._searchUser', context: context);

  @override
  String get _searchUser {
    _$_searchUserAtom.reportRead();
    return super._searchUser;
  }

  @override
  set _searchUser(String value) {
    _$_searchUserAtom.reportWrite(value, super._searchUser, () {
      super._searchUser = value;
    });
  }

  late final _$_UsersStateActionController =
      ActionController(name: '_UsersState', context: context);

  @override
  dynamic setSearchTerm(String value) {
    final _$actionInfo = _$_UsersStateActionController.startAction(
        name: '_UsersState.setSearchTerm');
    try {
      return super.setSearchTerm(value);
    } finally {
      _$_UsersStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initUsersListener() {
    final _$actionInfo = _$_UsersStateActionController.startAction(
        name: '_UsersState.initUsersListener');
    try {
      return super.initUsersListener();
    } finally {
      _$_UsersStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
imagefile: ${imagefile},
people: ${people}
    ''';
  }
}
