import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'indicator.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => _PieChartSample1State();
}

class _PieChartSample1State extends State<PieChartSample1> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Colors.blue, // Match color with CategoryCard
                text: 'Room Availability',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: Colors.red, // Match color with CategoryCard
                text: 'All Issues',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: Colors.green, // Match color with CategoryCard
                text: 'Staff Members',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: Colors.orange, // Match color with CategoryCard
                text: 'Create Staff',
                isSquare: false,
                size: touchedIndex == 3 ? 18 : 16,
                textColor: touchedIndex == 3
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                startDegreeOffset: 180,
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 1,
                centerSpaceRadius: 0,
                sections: showingSections(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final colors = [
          Colors.blue, // Match color with CategoryCard
          Colors.red, // Match color with CategoryCard
          Colors.green, // Match color with CategoryCard
          Colors.orange, // Match color with CategoryCard
        ];
        final titles = [
          'Room Availability',
          'All Issues',
          'Staff Members',
          'Create Staff'
        ];

        return PieChartSectionData(
          color: colors[i],
          value: 25,
          title: titles[i],
          radius: 60, // Adjust radius to fit better
          titlePositionPercentageOffset: 0.55,
          titleStyle: TextStyle(
            color: AppColors.contentColorWhite,
            fontSize: isTouched ? 18 : 14,
          ),
          borderSide: isTouched
              ? const BorderSide(color: AppColors.contentColorWhite, width: 6)
              : BorderSide(color: AppColors.contentColorWhite.withOpacity(0)),
        );
      },
    );
  }
}
