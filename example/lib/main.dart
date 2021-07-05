import 'package:flutter/material.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

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
        primarySwatch: Colors.blue,
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
          steps: 3,
          controller: PageController(),
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
        steps: 3,
        controller: PageController(),
        complete: () async {
          return Future.value(true);
        },
        children: List<Widget>.generate(
          3,
          (index) => Container(
            color: Color(0xffffffff),
            child: Center(
              child: Text(
                "$index",
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
