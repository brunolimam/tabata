import 'package:tabata/data/models/user_model.dart';

extension UserModelFixture on UserModel {
  static UserModel fixture({
    String name = 'name',
    String email = 'email',
  }) {
    return UserModel(name, email);
  }
}
