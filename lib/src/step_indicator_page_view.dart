import 'package:flutter/material.dart';
import 'package:linear_step_indicator/src/linear_step_indicator.dart';

import 'constants.dart';

class StepIndicatorPageView extends StatelessWidget {
  final int steps;
  final PageController controller;
  final List<Widget> children;
  final Color backgroundColor;
  final double spacing;
  final Complete? complete;

  const StepIndicatorPageView({
    Key? key,
    required this.steps,
    required this.controller,
    required this.children,
    this.spacing = 20,
    this.backgroundColor = kIconColor,
    this.complete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            LinearStepIndicator(
              steps: steps,
              controller: controller,
              backgroundColor: backgroundColor,
              complete: complete,
            ),
            SizedBox(height: spacing),
            Expanded(
              child: PageView(
                controller: controller,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
