import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/view/main_screens/settings.dart';
import 'package:streamline/widgets/weekly_chart.dart';

import '../../widgets/daily_progress.dart';
import '../../widgets/most_productive_day.dart';
import '../../widgets/most_productive_hour.dart';
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
                image: AssetImage('images/home/group13.png'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const DailyProgressTab(),
              const SizedBox(height: 20),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0,
                  color: AppColors.orange2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: toggle == 'weekly' ? AppColors.green : AppColors.orange2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onPressed: () {setState(() {
                            toggle = 'weekly';
                          });},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Text('Weekly',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: toggle == 'monthly' ? AppColors.green : AppColors.orange2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onPressed: () {setState(() {
                            toggle = 'monthly';
                          });},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Text('Monthly',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                  WeeklyChart(toggle: toggle),
                   const SizedBox(height: 20),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Expanded(child: MostProductiveHour()),
                        Expanded(child: MostProductiveDay()),
                    ],
                   )

            ],
          ),
        ),
      ),
    );
  }
}
