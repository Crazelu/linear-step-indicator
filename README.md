# linear_step_indicator

A Flutter package for adding beautiful step indicators in your apps.

## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  linear_step_indicator: ^1.0.0
```

Import the package in your project:

```dart
import 'package:linear_step_indicator/linear_step_indicator.dart';
```

## Getting Started

Examples:

```dart
LinearStepIndicator(
          steps: 3,
          controller: PageController(),
          labels: List<String>.generate(3, (index) => "Step ${index + 1}"),
          complete: () {
            //typically, you'd want to put logic that returns true when all the steps
            //are completed here
            return Future.value(true);
          },
        )
```



![Indicator](https://github.com/Crazelu/linear-step-indicator/blob/main/assets/indicator.png)




```dart
StepIndicatorPageView(
        steps: 3,
        indicatorPosition: IndicatorPosition.top,
        labels: List<String>.generate(3, (index) => "Step ${index + 1}"),
        controller: _pageController,
        complete: () {
          //typically, you'd want to put logic that returns true when all the steps
          //are completed here
          return Future.value(true);
        },
        children: List<Widget>.generate(
          3,
          (index) => Container(
            color: Color(0xffffffff),
            child: Center(
              child: Text(
                "Page ${index + 1}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      )
```

<img src="https://raw.githubusercontent.com/Crazelu/linear-step-indicator/main/assets/indicator-page.png" width="400" height="800">

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Crazelu/linear-step-indicator/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Crazelu/linear-step-indicator/pulls).
