import 'package:flutter/material.dart';
import 'package:linear_step_indicator/src/constants.dart';
import 'extensions.dart';
import 'node.dart';

class LinearStepIndicator extends StatefulWidget {
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
  const LinearStepIndicator({
    Key? key,
    required this.steps,
    required this.controller,
    this.activeBorderColor = kActiveColor,
    this.inActiveBorderColor = kInActiveColor,
    this.activeLineColor = kActiveLineColor,
    this.inActiveLineColor = kInActiveLineColor,
    this.activeNodeColor = kActiveColor,
    this.inActiveNodeColor = kInActiveNodeColor,
    this.iconSize = kIconSize,
    this.completedIcon = kCompletedIcon, //Icon showed when a step is completed
    this.nodeThickness = kDefaultThickness,
    this.nodeSize = kDefaultSize,
    this.verticalPadding = kDefaultSize,
    this.lineHeight = kDefaultLineHeight,
    this.shape = BoxShape.circle,
    this.iconColor = kIconColor,
    this.backgroundColor = kIconColor,
    this.complete,
  })  : assert(steps > 0, "steps value must be a non-zero positive integer"),
        super(key: key);

  @override
  _LinearStepIndicatorState createState() => _LinearStepIndicatorState();
}

class _LinearStepIndicatorState extends State<LinearStepIndicator> {
  late List<Node> nodes;
  late int lastStep;

  @override
  void initState() {
    super.initState();
    nodes = List<Node>.generate(widget.steps, (index) => Node(step: index));
    lastStep = 0;

    //listen to page changes to track when each step is ideally completed

    widget.controller.addListener(
      () async {
        if (widget.controller.page! > lastStep) {
          setState(
            () {
              nodes[lastStep].completed = true;
              lastStep = widget.controller.page!.ceil();
            },
          );
        }

        //checks if the controller has hit the max step
        //and checks [complete] to complete last node (or not)

        if (widget.controller.page! == widget.steps - 1 &&
            widget.complete != null) {
          if (await widget.complete!()) {
            nodes[widget.steps - 1].completed = true;
            setState(() {});
          }
        }
      },
    );
  }

  //returns active or inactive color depending on the completion status of [node]
  Color getColor(Node node) => node.completed || lastStep == node.step
      ? widget.activeBorderColor
      : widget.inActiveBorderColor;

  BorderSide side(Node node) => BorderSide(
        color: getColor(node),
        width: widget.nodeThickness,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var node in nodes) ...[
            Container(
              alignment: Alignment.topCenter,
              height: widget.nodeSize,
              width: widget.nodeSize,
              decoration: BoxDecoration(
                color: node.completed
                    ? widget.activeNodeColor
                    : widget.inActiveNodeColor,
                border: Border(
                  bottom: side(node),
                  top: side(node),
                  left: side(node),
                  right: side(node),
                ),
                shape: widget.shape,
              ),
              child: node.completed
                  ? Icon(
                      widget.completedIcon,
                      size: widget.iconSize,
                      color: widget.iconColor,
                    )
                  : null,
            ),
            if (node.step != widget.steps - 1)
              Container(
                color: node.completed
                    ? widget.activeLineColor
                    : widget.inActiveLineColor,
                height: widget.lineHeight,
                width: widget.steps > 3
                    ? context.screenWidth(1 / widget.steps) - 20
                    : context.screenWidth(1 / widget.steps) + 20,
              ),
          ],
        ],
      ),
    );
  }
}
