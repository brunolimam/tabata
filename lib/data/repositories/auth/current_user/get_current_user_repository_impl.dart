import 'package:tabata/domain/repositories/get_current_user_repository.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/domain/entities/user.dart';

class GetCurrentUserRepositoryImpl extends GetCurrentUserRepository {
  final GetCurrentUserService _service;

  GetCurrentUserRepositoryImpl(this._service);

  @override
  User? get() {
    return _service.get();
  }
}
