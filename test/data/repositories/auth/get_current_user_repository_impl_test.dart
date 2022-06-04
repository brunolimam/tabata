import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/auth/current_user/get_current_user_repository_impl.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';
import '../../fixtures/user_data_fixture.dart';
import 'get_current_user_repository_impl_test.mocks.dart';

@GenerateMocks([GetCurrentUserServiceImpl])
void main() {
  late MockGetCurrentUserServiceImpl service;
  late GetCurrentUserRepositoryImpl sut;

  setUp(() {
    service = MockGetCurrentUserServiceImpl();
    sut = GetCurrentUserRepositoryImpl(service);
  });

  test('get when service return null should return null', () {
    when(service.get()).thenReturn(null);

    expect(sut.get() == null, true);
  });

  test('get when service return null should return user', () {
    when(service.get()).thenReturn(UserModelFixture.fixture());

    expect(sut.get() == null, false);
  });
}
