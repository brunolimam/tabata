import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabata/data/models/user_model.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';

class GetCurrentUserServiceImpl extends GetCurrentUserService {
  final FirebaseAuth _firebaseAuth;

  GetCurrentUserServiceImpl(this._firebaseAuth);

  @override
  UserModel? get() {
    var firebaseAuthUser = _firebaseAuth.currentUser;
    if (firebaseAuthUser == null) return null;

    var name = firebaseAuthUser.displayName;
    var email = firebaseAuthUser.email;
    return UserModel(
      firebaseAuthUser.uid,
      name,
      email,
    );
  }
}
