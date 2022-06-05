// Mocks generated by Mockito 5.2.0 from annotations
// in tabata/test/data/repositories/tabata/get_current_tabata_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tabata/data/models/tabata_model.dart' as _i4;
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart'
    as _i5;
import 'package:tabata/data/services/tabata/get_current_tabata_service_impl.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [GetCurrentTabataServiceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCurrentTabataServiceImpl extends _i1.Mock
    implements _i2.GetCurrentTabataServiceImpl {
  MockGetCurrentTabataServiceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.TabataModel?> get(String? userId) =>
      (super.noSuchMethod(Invocation.method(#get, [userId]),
              returnValue: Future<_i4.TabataModel?>.value())
          as _i3.Future<_i4.TabataModel?>);
}

/// A class which mocks [GetCurrentUserServiceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCurrentUserServiceImpl extends _i1.Mock
    implements _i5.GetCurrentUserServiceImpl {
  MockGetCurrentUserServiceImpl() {
    _i1.throwOnMissingStub(this);
  }
}