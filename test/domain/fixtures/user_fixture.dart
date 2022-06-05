import 'package:tabata/domain/entities/user.dart';

extension UserFixture on User {
  static User fixture({
    String id = 'id',
    String name = 'name',
    String email = 'email',
  }) {
    return User(
      id,
      name,
      email,
    );
  }
}
