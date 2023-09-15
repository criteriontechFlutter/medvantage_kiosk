import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'my_text_theme.dart';

class ManikinCircularTimerMain extends StatelessWidget {
  final String second;
  final  double percent;
  final double ? radius;
  final double ? lineWidth;


  const ManikinCircularTimerMain({Key? key, required this.second, required this.percent, this.radius, this.lineWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            linearGradient: const LinearGradient(colors: [
              Color(0xFF3366FF),
              Color(0xFF00CCFF),
            ]),
            animateFromLastPercent: true,
            animation: true,
            circularStrokeCap: CircularStrokeCap.round,
            radius: radius ?? 35,
            lineWidth: lineWidth ?? 5,
            // percent: seconds / 60,
            percent: percent,
            center: Text(
                   second.toString(),
                style: MyTextThemeBebas().veryLargeWCB),

              // seconds == 0 ? '0' : seconds.toString()
          ),
        ],
      ),
    );
  }
}
