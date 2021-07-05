import 'package:flutter/material.dart';
import 'package:linear_step_indicator/src/linear_step_indicator.dart';

class StepIndicatorPageView extends StatelessWidget {
  final int steps;
  final PageController controller;
  final List<Widget> children;
  final double spacing;

  const StepIndicatorPageView({
    Key? key,
    required this.steps,
    required this.controller,
    required this.children,
    this.spacing = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            LinearStepIndicator(steps: steps, controller: controller),
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
