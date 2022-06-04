import 'package:tabata/domain/entities/user.dart';

extension UserFixture on User {
  static User fixture({
    String name = 'name',
    String email = 'email',
  }) {
    return User(
      name,
      email,
    );
  }
}
