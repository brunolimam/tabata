import 'package:flutter/material.dart';

abstract class ColorAsset {
  static get mainBackground => const Color(0xFF17191C);
  static get secondaryBackground => const Color(0xFF22262A);

  static get mainColor => const Color(0xFF603CA2);
  static get secondaryColor => const Color(0xFFB29FDF);
  static get textColor => const Color(0xFFFFFFFF);
  static get secondaryTextColor => const Color(0xFFABB2BA);
  static get iconColor => const Color(0xFFFFFFFF);

  static get dividerColor => const Color(0xFF454C54);

  static get disabledFieldColor => const Color(0xFF1C1E22);
  static get disabledTextFieldColor => const Color(0xFF737E8C);

  static get blackDivider => const Color(0xFF000000);
  static get tabataItemHeader => const Color(0xFFE3E5E8);

  static get restColor => const Color(0xFF6EBA5E);

  static get hardFeedbackTextColor => const Color(0xFFF5A189);
  static get hardFeedbackColor => const Color(0xFFFF5F33);
  static get lightFeedbackColor => const Color(0xFF50A63F);
  static get unselectedIconFeedbackColor => const Color(0xFF5C6570);
  static get borderFeedbackColor => const Color(0xFF707070);
  static get workoutItemDividerColor => const Color(0xFF2E3338);
}
