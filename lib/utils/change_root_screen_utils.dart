import 'package:flutter/cupertino.dart';
import 'package:tabata/presentation/first_setup/first_setup_widget.dart';

class ChangeRootScreenUtils {
  static void changeToFirsSetup(BuildContext context) {
    _change(context, FirstSetupWidget(), "/firstSetup");
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
