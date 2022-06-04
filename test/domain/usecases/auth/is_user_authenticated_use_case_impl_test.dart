import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/auth/current_user/get_current_user_repository_impl.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case_impl.dart';

import '../../fixtures/user_fixture.dart';
import 'is_user_authenticated_use_case_impl_test.mocks.dart';

@GenerateMocks([GetCurrentUserRepositoryImpl])
void main() {
  late MockGetCurrentUserRepositoryImpl repository;
  late IsUserAuthenticatedUseCaseImpl sut;

  setUp(() {
    repository = MockGetCurrentUserRepositoryImpl();
    sut = IsUserAuthenticatedUseCaseImpl(repository);
  });

  test('execute when repository return user should return yes', () {
    when(repository.get()).thenReturn(UserFixture.fixture());

    var result = sut.execute();
    expect(result, true);
  });

  test('execute when repository do not return user should return false', () {
    when(repository.get()).thenReturn(null);

    var result = sut.execute();
    expect(result, false);
  });
}
