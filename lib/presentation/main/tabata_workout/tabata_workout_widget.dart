import 'package:flutter/material.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/utils/dimens.dart';

class TabataWorkoutWidget extends StatelessWidget {
  final Tabata tabata;

  const TabataWorkoutWidget({
    required this.tabata,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.horizontal,
        ),
      ),
    ));
  }
}
