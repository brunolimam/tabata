import 'package:tabata/domain/repositories/get_current_user_repository.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case.dart';

class IsUserAuthenticatedUseCaseImpl extends IsUserAuthenticatedUseCase {
  final GetCurrentUserRepository _getCurrentUserRepository;

  IsUserAuthenticatedUseCaseImpl(this._getCurrentUserRepository);

  @override
  bool execute() {
    return _getCurrentUserRepository.get() != null;
  }
}
