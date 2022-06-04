import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case.dart';

class GetTextFromTimeUseCaseImpl extends GetTextFromTimeUseCase {
  @override
  String execute(Time value) {
    return [_getTime(value.minutes), _getTime(value.seconds)].join(":");
  }

  String _getTime(int time) {
    return time.toString().padLeft(2, '0');
  }
}
