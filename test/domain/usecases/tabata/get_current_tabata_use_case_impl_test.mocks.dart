// Mocks generated by Mockito 5.2.0 from annotations
// in tabata/test/domain/usecases/tabata/get_current_tabata_use_case_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tabata/data/repositories/tabata/get_current_tabata_repository_impl.dart'
    as _i2;
import 'package:tabata/domain/entities/tabata.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [GetCurrentTabataRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCurrentTabataRepositoryImpl extends _i1.Mock
    implements _i2.GetCurrentTabataRepositoryImpl {
  MockGetCurrentTabataRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Tabata?> get() =>
      (super.noSuchMethod(Invocation.method(#get, []),
          returnValue: Future<_i4.Tabata?>.value()) as _i3.Future<_i4.Tabata?>);
}
