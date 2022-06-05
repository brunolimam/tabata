import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/tabata/get_current_tabata_repository_impl.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service_impl.dart';
import '../../fixtures/tabata_model_fixture.dart';
import '../../fixtures/user_model_fixture.dart';
import 'get_current_tabata_repository_impl_test.mocks.dart';

@GenerateMocks([
  GetCurrentTabataServiceImpl,
  GetCurrentUserServiceImpl,
])
void main() {
  late MockGetCurrentUserServiceImpl getCurrentUserServiceMock;
  late MockGetCurrentTabataServiceImpl getCurrentTabataServiceMock;
  late GetCurrentTabataRepositoryImpl sut;

  setUp(() {
    getCurrentUserServiceMock = MockGetCurrentUserServiceImpl();
    getCurrentTabataServiceMock = MockGetCurrentTabataServiceImpl();
    sut = GetCurrentTabataRepositoryImpl(
      getCurrentTabataServiceMock,
      getCurrentUserServiceMock,
    );
  });

  test('get when user is not logged should return null', () async {
    when(getCurrentUserServiceMock.get()).thenReturn(null);
    var result = await sut.get();
    expect(result, null);
  });

  test('get when user is logged and doest have tabata should return null',
      () async {
    var user = UserModelFixture.fixture();
    when(getCurrentUserServiceMock.get()).thenReturn(user);
    when(getCurrentTabataServiceMock.get(user.id)).thenAnswer(
      (_) async => null,
    );

    var result = await sut.get();
    expect(result, null);
  });

  test('get when user is logged and has tabata should return tabata', () async {
    var user = UserModelFixture.fixture();
    when(getCurrentUserServiceMock.get()).thenReturn(user);
    when(getCurrentTabataServiceMock.get(user.id)).thenAnswer(
      (_) async => TabataModelFixture.fixture(),
    );

    var result = await sut.get();
    expect(result == null, false);
  });
}
