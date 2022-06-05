import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/repositories/get_current_tabata_repository.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';

class GetCurrentTabataUseCaseImpl extends GetCurrentTabataUseCase {
  final GetCurrentTabataRepository _repository;

  GetCurrentTabataUseCaseImpl(this._repository);

  @override
  Future<Tabata> execute() async {
    var tabata = await _repository.get();
    if (tabata == null) return const Tabata.defaultValue();

    return tabata;
  }
}
