import 'package:flutter/material.dart';
import 'package:linear_step_indicator/src/constants.dart';
import 'extensions.dart';
import 'node.dart';

class FullLinearStepIndicator extends StatefulWidget {
  ///Controller for tracking page changes.
  ///
  ///Typically, controller should animate or jump to next page
  ///when a step is completed
  final PageController controller;

  ///Number of nodes to paint on screen
  final int steps;

  ///[completedIcon] size
  final double iconSize;

  ///Size of each node
  final double nodeSize;

  ///Height of separating line
  final double lineHeight;

  ///Icon showed when a step is completed
  final IconData completedIcon;

  ///Color of each completed node border
  final Color activeBorderColor;

  ///Color of each uncompleted node border
  final Color inActiveBorderColor;

  ///Color of each separating line after a completed node
  final Color activeLineColor;

  ///Color of each separating line after an uncompleted node
  final Color inActiveLineColor;

  ///Background color of a completed node
  final Color activeNodeColor;

  ///Background color of an uncompleted node
  final Color inActiveNodeColor;

  ///Thickness of node's borders
  final double nodeThickness;

  ///Node's shape
  final BoxShape shape;

  ///[completedIcon] color
  final Color iconColor;

  ///Step indicator's background color
  final Color backgroundColor;

  ///Boolean function that returns [true] when last node should be completed
  final Complete? complete;

  ///Step indicator's vertical padding
  final double verticalPadding;

  ///Labels for individual nodes
  final List<String> labels;

  ///Textstyle for an active label
  final TextStyle? activeLabelStyle;

  ///Textstyle for an inactive label
  final TextStyle? inActiveLabelStyle;

  const FullLinearStepIndicator({
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
    this.completedIcon = kCompletedIcon,
    this.nodeThickness = kDefaultThickness,
    this.nodeSize = kDefaultSize,
    this.verticalPadding = kDefaultSize,
    this.lineHeight = kDefaultLineHeight,
    this.shape = BoxShape.circle,
    this.iconColor = kIconColor,
    this.backgroundColor = kIconColor,
    this.complete,
    this.labels = const <String>[],
    this.activeLabelStyle,
    this.inActiveLabelStyle,
  })  : assert(steps > 0, "steps value must be a non-zero positive integer"),
        assert(labels.length == steps || labels.length == 0,
            "Provide exactly $steps strings for labels"),
        super(key: key);

  @override
  _FullLinearStepIndicatorState createState() =>
      _FullLinearStepIndicatorState();
}

class _FullLinearStepIndicatorState extends State<FullLinearStepIndicator> {
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

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.white, width: 2.5);
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
        color: widget.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var node in nodes) ...[
                  if (nodes.indexOf(node) == 0) ...{
                    Container(
                      color: node.completed
                          ? widget.activeLineColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: context.screenWidth(1 / widget.steps) * .25,
                    ),
                  },
                  Container(
                    alignment: Alignment.center,
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: node.completed
                          ? widget.activeNodeColor
                          : widget.inActiveNodeColor,
                      border: Border(
                        top: borderSide,
                        bottom: borderSide,
                        left: borderSide,
                        right: borderSide,
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: .5,
                          blurRadius: .5,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(.4),
                        ),
                      ],
                    ),
                    child: Text(
                      "${nodes.indexOf(node) + 1}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (node.step != widget.steps - 1)
                    Container(
                      color: node.completed
                          ? widget.activeLineColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: widget.steps > 3
                          ? context.screenWidth(1 / widget.steps) - 40
                          : context.screenWidth(1 / widget.steps) - 28,
                    ),
                  if (nodes.indexOf(node) == widget.steps - 1) ...{
                    Container(
                      color: node.completed
                          ? widget.activeLineColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: context.screenWidth(1 / widget.steps) * .25,
                    ),
                  },
                ],
              ],
            ),
            SizedBox(height: 6),
            if (widget.labels.length > 0) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.labels.length; i++) ...[
                    Text(
                      widget.labels[i],
                      style: nodes[i].completed
                          ? widget.activeLabelStyle
                          : widget.inActiveLabelStyle,
                    ),
                    if (widget.labels[i] !=
                        widget.labels[widget.steps - 1]) ...[
                      SizedBox(
                        width: widget.steps > 3
                            ? context.screenWidth(1 / widget.steps) - 45
                            : context.screenWidth(1 / widget.steps) - 35,
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
