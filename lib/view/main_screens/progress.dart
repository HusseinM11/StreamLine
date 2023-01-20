import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/view/main_screens/settings.dart';
import 'package:streamline/view/widgets/weekly_chart.dart';

import '../widgets/daily_progress.dart';
import '../widgets/most_productive_day.dart';
import '../widgets/most_productive_hour.dart';
import 'habits.dart';
import 'home.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}



class _ProgressScreenState extends State<ProgressScreen> {
  String toggle = 'weekly';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg2,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home/group13.png'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const DailyProgressTab(),
              const SizedBox(height: 20),
              WeeklyChart(toggle: toggle),
                   const SizedBox(height: 20),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                        Expanded(child: MostProductiveHour()),
                        Expanded(child: MostProductiveDay()),
                    ],
                   ),
                  const SizedBox(height: 20),
                  

            ],
          ),
        ),
      ),
    );
  }
}
