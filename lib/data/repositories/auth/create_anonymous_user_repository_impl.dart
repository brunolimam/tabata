import 'package:tabata/data/services/auth/create_anonymous_user_service.dart';
import 'package:tabata/domain/repositories/create_anonymous_user_repository.dart';

class CreateAnonymousUserRepositoryImpl extends CreateAnonymousUserRepository {
  final CreateAnonymousUserService _service;

  CreateAnonymousUserRepositoryImpl(this._service);

  @override
  Future<void> create() async {
    await _service.create();
  }
}
