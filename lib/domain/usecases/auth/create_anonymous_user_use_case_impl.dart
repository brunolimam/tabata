import 'package:tabata/domain/repositories/create_anonymous_user_repository.dart';
import 'package:tabata/domain/usecases/auth/create_anonymous_user_use_case.dart';

class CreateAnonymousUserUseCaseImpl extends CreateAnonymousUserUseCase {
  final CreateAnonymousUserRepository _repository;

  CreateAnonymousUserUseCaseImpl(this._repository);

  @override
  Future<void> execute() async {
    await _repository.create();
  }
}
