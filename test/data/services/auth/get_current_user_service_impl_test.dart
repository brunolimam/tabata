import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late GetCurrentUserServiceImpl sut;

  test('get when firebase auth is authenticated should return user model', () {
    mockFirebaseAuth = MockFirebaseAuth(
      signedIn: true,
      mockUser: MockUser(
        displayName: "name",
        email: "someemail@mail.com",
      ),
    );
    sut = GetCurrentUserServiceImpl(mockFirebaseAuth);

    var user = sut.get();
    expect(user == null, false);
  });

  test('get when firease auth it not autenticated should not return user model',
      () {
    mockFirebaseAuth = MockFirebaseAuth();
    sut = GetCurrentUserServiceImpl(mockFirebaseAuth);

    var user = sut.get();
    expect(user == null, true);
  });
}
