import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/domain/usecases/auth/create_anonymous_user_use_case.dart';
import 'package:tabata/presentation/first_setup/first_setup_widget.dart';
import 'package:tabata/presentation/main/main_widget.dart';

class ChangeRootScreenUtils {
  static void changeToFirsSetup(BuildContext context) {
    CreateAnonymousUserUseCase createAnonymousUserUseCase =
        GetIt.instance.get<CreateAnonymousUserUseCase>();
    _change(
      context,
      FirstSetupWidget(
        createAnonymousUserUseCase: createAnonymousUserUseCase,
      ),
      "/firstSetup",
    );
  }

  static void changeToWorkout(BuildContext context) {
    _change(context, const MainWidget(), "/workout");
  }

  static void _change(BuildContext context, Widget page, String name) {
    Route route = CupertinoPageRoute(builder: (context) => page);
    Navigator.pushAndRemoveUntil(
      context,
      route,
      ModalRoute.withName(name),
    );
  }
}
