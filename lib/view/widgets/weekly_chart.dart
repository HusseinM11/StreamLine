import 'dart:math';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/controller/all_tasksController.dart';

import '../../constants/colors.dart';

class WeeklyChart extends StatefulWidget {
  String toggle;
  WeeklyChart({super.key, required this.toggle});

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
        color: AppColors.orange2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('Weekly Activity',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
                      SizedBox(height: 5),
              GetX<AllTasksController>(
                initState: (_) async {
                      Get.find<AllTasksController>();
                    },
                builder: (controller) {
                  return Text('You have completed ${controller.getWeeklyStats().sum} ${controller.getWeeklyStats().sum > 1 ? "tasks" : "task"} this week.',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white));
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                  height: 300,
                  child: GetX<AllTasksController>(
                    initState: (_) async {
                      Get.find<AllTasksController>();
                    },
                    builder: (controller) {
                      
                      var barGroupData = controller
                          .getWeeklyStats()
                          .asMap()
                          .map((key, val) => MapEntry(
                              key,
                              BarChartGroupData(
                                x: key,
                                barRods: [
                                  BarChartRodData(
                                      width: 15,
                                      backDrawRodData:
                                          BackgroundBarChartRodData(
                                        color: AppColors.bg2,
                                        show: true,
                                        toY: controller
                                                    .getWeeklyStats()
                                                    .reduce(max)
                                                    .toDouble() ==
                                                0
                                            ? 10
                                            : controller
                                                .getWeeklyStats()
                                                .reduce(max)
                                                .toDouble(),
                                      ),
                                      toY: val.toDouble(),
                                      color: key == index
                                          ? AppColors.green
                                          : AppColors.green),
                                ],
                              )))
                          .values
                          .toList();
                      return BarChart(
                          swapAnimationDuration:
                              const Duration(milliseconds: 250), // Optional
                          swapAnimationCurve: Curves.bounceOut,
                          BarChartData(
                            barTouchData: BarTouchData(
                              touchTooltipData: barToolTipData(context),
                              touchCallback:
                                  (FlTouchEvent event, barTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      barTouchResponse == null ||
                                      barTouchResponse.spot == null) {
                                    index = -1;
                                    return;
                                  }
                                  index = barTouchResponse
                                      .spot!.touchedBarGroupIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            alignment: BarChartAlignment.spaceAround,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: ((value, meta) => getTitles(
                                      value,
                                      meta,
                                      Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      AppColors.green)),
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            barGroups: barGroupData,
                          ));
                    },
                  ))
            ],
          ),
        ));
  }
}

Widget getTitles(double value, TitleMeta meta, Color color, Color backColor) {
  var style = TextStyle(
    color: color,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Mon';
      break;
    case 1:
      text = 'Tue';
      break;
    case 2:
      text = 'Wed';
      break;
    case 3:
      text = 'Thu';
      break;
    case 4:
      text = 'Fri';
      break;
    case 5:
      text = 'Sat';
      break;
    case 6:
      text = 'Sun';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4.0,
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: DateFormat("EEE").format(DateTime.now()) == text
                ? AppColors.green
                : null),
        child: Text(text, style: style)),
  );
}

BarTouchTooltipData barToolTipData(BuildContext context) {
  return BarTouchTooltipData(
    tooltipRoundedRadius: 10,
    tooltipBgColor: AppColors.green,
    getTooltipItem: (group, groupIndex, rod, rodIndex) {
      String weekDay;
      switch (group.x.toInt()) {
        case 0:
          weekDay = 'Monday';
          break;
        case 1:
          weekDay = 'Tuesday';
          break;
        case 2:
          weekDay = 'Wednesday';
          break;
        case 3:
          weekDay = 'Thursday';
          break;
        case 4:
          weekDay = 'Friday';
          break;
        case 5:
          weekDay = 'Saturday';
          break;
        case 6:
          weekDay = 'Sunday';
          break;
        default:
          throw Error();
      }
      return BarTooltipItem(
        '$weekDay\n',
        TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600
        ),
        children: <TextSpan>[
          TextSpan(
              text: '${rod.toY.toInt()}',
              style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700
              )),
        ],
      );
    },
  );
}
