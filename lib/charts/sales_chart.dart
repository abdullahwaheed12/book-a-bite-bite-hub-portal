import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/global.dart';

class LineChartSample2 extends StatefulWidget {
  // const LineChartSample2({) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xffFFA500),
    Global.deepOrange.withOpacity(0.5),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.15,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ));
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      // gridData: FlGridData(
      //   show: true,
      //   drawHorizontalLine: true,
      //   getDrawingVerticalLine: (value) {
      //     return FlLine(
      //       color:  Colors.white,
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingHorizontalLine: (value) {
      //     return FlLine(
      //       color:  Colors.white,
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          // getTextStyles: (context, value) => const TextStyle(
          //     color: Color(0xff68737d),
          //     fontWeight: FontWeight.bold,
          //     fontSize: 16),
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 2:
                return const Text('MAR');
              case 5:
                return const Text('JUN');
              case 8:
                return const Text('SEP');
            }
            return const Text('');
          },

          interval: 1,
        )),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          // getTextStyles: (context, value) => const TextStyle(
          //   color: Color(0xff67727d),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 15,
          // ),
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 1:
                return const Text('10k');
              case 3:
                return const Text('30k');
              case 5:
                return const Text('50k');
            }
            return const Text('');
          },
          reservedSize: 32,
          interval: 1,
        )),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xffFFFFFF), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3.44),
            const FlSpot(2.6, 3.44),
            const FlSpot(4.9, 3.44),
            const FlSpot(6.8, 3.44),
            const FlSpot(8, 3.44),
            const FlSpot(9.5, 3.44),
            const FlSpot(11, 3.44),
          ],
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
          ),
        ),
      ],
    );
  }
}
