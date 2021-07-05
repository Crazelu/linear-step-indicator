import 'package:flutter/material.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

const int STEPS = 3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Step Indicator Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StepIndicatorPageViewDemo(),
    );
  }
}

class StepIndicatorDemo extends StatelessWidget {
  const StepIndicatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LinearStepIndicator(
          steps: STEPS,
          controller: PageController(),
          complete: () {
            //typically, you'd want to put logic that returns true when all the steps
            //are completed here
            return Future.value(true);
          },
        ),
      ),
    );
  }
}

class StepIndicatorPageViewDemo extends StatelessWidget {
  const StepIndicatorPageViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StepIndicatorPageView(
        steps: STEPS,
        indicatorPosition: IndicatorPosition.bottom,
        controller: PageController(),
        complete: () {
          //typically, you'd want to put logic that returns true when all the steps
          //are completed here
          return Future.value(true);
        },
        children: List<Widget>.generate(
          STEPS,
          (index) => Container(
            color: Color(0xffffffff),
            child: Center(
              child: Text(
                "Page $index",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
