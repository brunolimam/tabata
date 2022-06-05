import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/repositories/get_current_tabata_repository.dart';

class GetCurrentTabataRepositoryImpl extends GetCurrentTabataRepository {
  final GetCurrentTabataService _service;
  final GetCurrentUserService _getCurrentUserService;

  GetCurrentTabataRepositoryImpl(
    this._service,
    this._getCurrentUserService,
  );

  @override
  Future<Tabata?> get() async {
    var user = _getCurrentUserService.get();
    if (user == null) return null;

    return await _service.get(user.id);
  }
}
