import 'package:flutter/material.dart';
import 'package:linear_step_indicator/src/linear_step_indicator.dart';

import 'constants.dart';

class StepIndicatorPageView extends StatelessWidget {
  final List<Widget> children;
  final PageController controller;
  final int steps;
  final double iconSize;
  final double nodeSize;
  final double lineHeight;
  final IconData completedIcon;
  final Color activeBorderColor;
  final Color inActiveBorderColor;
  final Color activeLineColor;
  final Color inActiveLineColor;
  final Color activeNodeColor;
  final Color inActiveNodeColor;
  final double nodeThickness;
  final BoxShape shape;
  final Color iconColor;
  final Color backgroundColor;
  final Complete? complete;
  final double verticalPadding;
  final double spacing;
  final double bottomSpacing;
  final IndicatorPosition indicatorPosition;

  const StepIndicatorPageView({
    Key? key,
    required this.steps,
    required this.controller,
    required this.children,
    this.activeBorderColor = kActiveColor,
    this.inActiveBorderColor = kInActiveColor,
    this.activeLineColor = kActiveLineColor,
    this.inActiveLineColor = kInActiveLineColor,
    this.activeNodeColor = kActiveColor,
    this.inActiveNodeColor = kInActiveNodeColor,
    this.iconSize = kIconSize,
    this.completedIcon = kCompletedIcon,
    this.nodeThickness = kDefaultThickness,
    this.nodeSize = kDefaultSize,
    this.verticalPadding = kDefaultSize,
    this.lineHeight = kDefaultLineHeight,
    this.shape = BoxShape.circle,
    this.iconColor = kIconColor,
    this.backgroundColor = kIconColor,
    this.spacing = kDefaultSize,
    this.bottomSpacing = 0,
    this.indicatorPosition = IndicatorPosition.top,
    this.complete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            if (indicatorPosition == IndicatorPosition.top) ...[
              LinearStepIndicator(
                steps: steps,
                controller: controller,
                backgroundColor: backgroundColor,
                complete: complete,
                activeBorderColor: activeBorderColor,
                inActiveBorderColor: inActiveBorderColor,
                activeLineColor: activeLineColor,
                inActiveLineColor: inActiveLineColor,
                activeNodeColor: activeNodeColor,
                inActiveNodeColor: inActiveNodeColor,
                shape: shape,
                iconColor: iconColor,
                iconSize: iconSize,
                verticalPadding: verticalPadding,
                completedIcon: completedIcon,
                lineHeight: lineHeight,
                nodeSize: nodeSize,
                nodeThickness: nodeThickness,
              ),
              SizedBox(height: spacing),
            ],
            Expanded(
              child: PageView(
                controller: controller,
                children: children,
              ),
            ),
            if (indicatorPosition == IndicatorPosition.bottom) ...[
              SizedBox(height: spacing),
              LinearStepIndicator(
                steps: steps,
                controller: controller,
                backgroundColor: backgroundColor,
                complete: complete,
                activeBorderColor: activeBorderColor,
                inActiveBorderColor: inActiveBorderColor,
                activeLineColor: activeLineColor,
                inActiveLineColor: inActiveLineColor,
                activeNodeColor: activeNodeColor,
                inActiveNodeColor: inActiveNodeColor,
                shape: shape,
                iconColor: iconColor,
                iconSize: iconSize,
                verticalPadding: verticalPadding,
                completedIcon: completedIcon,
                lineHeight: lineHeight,
                nodeSize: nodeSize,
                nodeThickness: nodeThickness,
              ),
              SizedBox(height: bottomSpacing),
            ],
          ],
        ),
      ),
    );
  }
}

enum IndicatorPosition { top, bottom }
