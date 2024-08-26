import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../api_services/api_utils.dart';
import '../../../theme/colors.dart';
import 'indicator.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => _PieChartSample1State();
}

class _PieChartSample1State extends State<PieChartSample1> {
  int touchedIndex = -1;
  List<ChartData>? _chartData;

  @override
  void initState() {
    super.initState();
    fetchPieChartData();
  }

  Future<void> fetchPieChartData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}${ApiUrls.fetchPieChartData}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final roomChangeChart = data['result'][0]['roomChangeIssueChart'];

        setState(() {
          _chartData = [
            ChartData(
                label: 'Approved',
                value: roomChangeChart['totalRoomChangeRequestsApproved']
                    .toDouble(),
                color: Colors.green),
            ChartData(
                label: 'Rejected',
                value: roomChangeChart['totalRoomChangeRequestsRejected']
                    .toDouble(),
                color: Colors.red),
            ChartData(
                label: 'Pending',
                value: (roomChangeChart['totalNumberRoomChangeRequest'] -
                        roomChangeChart['totalRoomChangeRequestsApproved'] -
                        roomChangeChart['totalRoomChangeRequestsRejected'])
                    .toDouble(),
                color: Colors.grey),
          ];
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error appropriately
    }
  }

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
            children: _chartData == null
                ? []
                : _chartData!.map((data) {
                    return Indicator(
                      color: data.color,
                      text: data.label,
                      isSquare: false,
                      size: touchedIndex == _chartData!.indexOf(data) ? 18 : 16,
                      textColor: touchedIndex == _chartData!.indexOf(data)
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    );
                  }).toList(),
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: _chartData == null
                ? const CircularProgressIndicator()
                : PieChart(
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
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (_chartData == null) return [];

    return List.generate(
      _chartData!.length,
      (i) {
        final isTouched = i == touchedIndex;
        final data = _chartData![i];

        return PieChartSectionData(
          color: data.color,
          value: data.value,
          title: data.label,
          radius: 60,
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

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({required this.label, required this.value, required this.color});
}
