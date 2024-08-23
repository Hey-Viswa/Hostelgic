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
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'One',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0 ? Colors.blue : AppColors.kGreyDk,
              ),
              Indicator(
                color: Colors.red,
                text: 'Two',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1 ? Colors.red : AppColors.kGreyDk,
              ),
              Indicator(
                color: Colors.green,
                text: 'Three',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2 ? Colors.green : AppColors.kGreyDk,
              ),
              Indicator(
                color: Colors.orange,
                text: 'Four',
                isSquare: false,
                size: touchedIndex == 3 ? 18 : 16,
                textColor:
                    touchedIndex == 3 ? Colors.orange : AppColors.kGreyDk,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
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
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
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
        const color0 = Colors.blue;
        const color1 = Colors.red;
        const color2 = Colors.green;
        const color3 = Colors.orange;

        final color = [color0, color1, color2, color3][i];
        final title = ['One', 'Two', 'Three', 'Four'][i];
        final titleColor =
            AppColors.kBackgroundColor; // Ensure the text is visible

        return PieChartSectionData(
          color: color,
          value: 25,
          title: title,
          // Set the title for each section
          radius: 80 - i * 10,
          // Adjust radius based on index if needed
          titlePositionPercentageOffset: 0.55,
          titleStyle: TextStyle(
            color: titleColor,
            fontSize: isTouched ? 18 : 14, // Adjust font size if needed
          ),
          borderSide: isTouched
              ? const BorderSide(color: AppColors.contentColorWhite, width: 6)
              : BorderSide(color: AppColors.contentColorWhite.withOpacity(0)),
        );
      },
    );
  }
}
