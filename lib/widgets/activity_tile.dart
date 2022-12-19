import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants/colors.dart';
import '../model/activity.dart';

class ActivityTile extends StatefulWidget {
  
  final Function() onPressed;
  ActivityModel activity;

   ActivityTile(
      {Key? key,
      required this.activity,
      required this.onPressed,
      })
      : super(
          key: key,
        );

  @override
  State<ActivityTile> createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
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
    return widget.activity.timeSpent / (widget.activity.timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          width: 130,
          height: 10,
          decoration: BoxDecoration(
              color: const Color(0xFFFF6E50),
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
                          widget.activity.content,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatToMinSec(widget.activity.timeSpent) +
                          ' / ' +
                          widget.activity.timeGoal.toString() +
                          ' = ' +
                          (100 * percentCompleted()).toStringAsFixed(0) +
                          '%',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
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
                              backgroundColor: AppColors.orange,
                              progressColor: Colors.white,
                              percent: percentCompleted() < 1
                                  ? percentCompleted()
                                  : 1,
                              radius: 30,
                              lineWidth: 5,
                            ),
                            Center(
                              child: IconButton(
                                onPressed: widget.onPressed,
                                icon: Icon(
                                    widget.activity.started
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
    );
  }
}
