import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/data/repositories/tabata/set_current_tabata_repository_impl.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service_impl.dart';
import '../../fixtures/tabata_model_fixture.dart';
import '../../fixtures/user_model_fixture.dart';
import 'set_current_tabata_repository_impl_test.mocks.dart';

@GenerateMocks([
  SetCurrentTabataServiceImpl,
  GetCurrentUserServiceImpl,
])
void main() {
  late MockSetCurrentTabataServiceImpl service;
  late MockGetCurrentUserServiceImpl getCurrentUserService;
  late SetCurrentTabataRepositoryImpl sut;

  setUp(() {
    service = MockSetCurrentTabataServiceImpl();
    getCurrentUserService = MockGetCurrentUserServiceImpl();
    sut = SetCurrentTabataRepositoryImpl(service, getCurrentUserService);
  });

  test('set when user is not logged should not set tabata', () async {
    var tabata = TabataModelFixture.fixture();
    var userId = 'userId';

    when(getCurrentUserService.get()).thenReturn(null);
    when(service.set(tabata, userId)).thenAnswer((_) async => {});

    await sut.set(tabata);
    verify(getCurrentUserService.get()).called(1);
    verifyNever(service.set(tabata, userId));
  });

  test('set when user is logged should set tabata', () async {
    var tabata = TabataModelFixture.fixture();
    var user = UserModelFixture.fixture();

    when(getCurrentUserService.get()).thenReturn(user);
    when(service.set(tabata, user.id)).thenAnswer((_) async => {});

    await sut.set(tabata);
    verify(getCurrentUserService.get()).called(1);
    verify(service.set(tabata, user.id)).called(1);
  });
}
