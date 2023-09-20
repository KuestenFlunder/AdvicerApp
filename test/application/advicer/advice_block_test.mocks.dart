// Mocks generated by Mockito 5.1.0 from annotations
// in api_name/test/application/advicer/advice_block_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:api_name/domain/entities/advice_Entity.dart' as _i7;
import 'package:api_name/domain/failures/failures.dart' as _i6;
import 'package:api_name/domain/repositories/advicer_repository.dart' as _i2;
import 'package:api_name/domain/usecases/advicer_usecases.dart' as _i4;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAdvicerRepository_0 extends _i1.Fake
    implements _i2.AdvicerRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [AdvicerUsecases].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdvicerUsecases extends _i1.Mock implements _i4.AdvicerUsecases {
  MockAdvicerUsecases() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AdvicerRepository get advicerRepository =>
      (super.noSuchMethod(Invocation.getter(#advicerRepository),
          returnValue: _FakeAdvicerRepository_0()) as _i2.AdvicerRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>> getAdviceUsecase() =>
      (super.noSuchMethod(Invocation.method(#getAdviceUsecase, []),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>.value(
              _FakeEither_1<_i6.Failure, _i7.AdviceEntity>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>);
}