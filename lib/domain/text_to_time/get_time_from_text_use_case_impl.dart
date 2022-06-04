import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case.dart';

class GetTimeFromTextUseCaseImpl extends GetTimeFromTextUseCase {
  @override
  Time execute(String value) {
    return Time(
      _getMinutes(value),
      _getSeconds(value),
    );
  }

  int _getMinutes(String value) {
    var values = value.split(":");
    return int.parse(values.first);
  }

  int _getSeconds(String value) {
    var values = value.split(":");
    return int.parse(values.last);
  }
}
