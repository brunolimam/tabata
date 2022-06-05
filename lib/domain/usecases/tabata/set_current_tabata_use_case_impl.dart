import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/repositories/set_current_tabata_repository.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case.dart';

class SetCurrentTabataUseCaseImpl extends SetCurrentTabataUseCase {
  final SetCurrentTabataRepository _repository;

  SetCurrentTabataUseCaseImpl(this._repository);

  @override
  Future<void> execute(Tabata tabata) async {
    await _repository.set(tabata);
  }
}
