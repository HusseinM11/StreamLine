import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants/colors.dart';
import '../../model/activity.dart';

class ActivityTile extends StatelessWidget {
  final Function() onPlay;
  final Function() onDoubleTap;
  final Function() onDone;

  ActivityModel activity;

  ActivityTile(
      {Key? key,
      required this.onDoubleTap,
      required this.activity,
      required this.onPlay,
      required this.onDone})
      : super(
          key: key,
        );

  // convert minutes to hour format
  String getDuration(int minutes) {
  String hrs = ((minutes / 60).floor()).toString();
  String remMins = (minutes % 60).toString();

  if (minutes % 60 == 0) {
    return hrs;
  } else {
    return "$hrs:${remMins.padLeft(2, '0')}";
  }
}


  int secondsToMinutes(int seconds) {
    return (seconds / 60).floor();
  }

  //convert seconds to minutes
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ':' + secs;
  }

  // calculate percentage
  double percentCompleted() {
    return activity.timeSpent / (activity.timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onDoubleTap: onDoubleTap,
        child: Container(
            width: 150,
            height: 10,
            decoration: BoxDecoration(
                color: AppColors.orange2,
                /* gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 211, 27, 7),
                  Color(0xFFFFC500)
                ]), */
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            activity.content,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            getDuration(secondsToMinutes(activity.timeSpent)) +
                                ' / ' +
                                getDuration(activity.timeGoal) +
                                'hr' +
                                ' = ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Text(
                              (100 * percentCompleted()).toStringAsFixed(0) +
                                  '%',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              CircularPercentIndicator(
                                backgroundColor: AppColors.orange.withOpacity(0.5),
                                progressColor: Colors.white,
                                percent: percentCompleted() < 1
                                    ? percentCompleted()
                                    : 1,
                                radius: 30,
                                lineWidth: 5,
                              ),
                              Center(
                                child: activity.isCompleted
                                    ? IconButton(
                                        onPressed: onDone,
                                        icon: const Icon(FeatherIcons.check,
                                            size: 24, color: Colors.white),
                                      )
                                    : IconButton(
                                        onPressed: onPlay,
                                        icon: Icon(
                                            activity.started
                                                ? FeatherIcons.pause
                                                : FeatherIcons.play,
                                            size: 24,
                                            color: Colors.white),
                                      ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
