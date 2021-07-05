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
      home: StepIndicatorDemo(),
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
