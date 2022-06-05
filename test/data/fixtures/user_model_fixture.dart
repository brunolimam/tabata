import 'package:tabata/data/models/user_model.dart';

extension UserModelFixture on UserModel {
  static UserModel fixture({
    String id = 'id',
    String name = 'name',
    String email = 'email',
  }) {
    return UserModel(
      id,
      name,
      email,
    );
  }
}
