import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabata/data/services/auth/create_anonymous_user_service.dart';

class CreateAnonymousUserServiceImpl extends CreateAnonymousUserService {
  final FirebaseAuth _firebaseAuth;

  CreateAnonymousUserServiceImpl(this._firebaseAuth);

  @override
  Future<void> create() async {
    await _firebaseAuth.signInAnonymously();
  }
}
