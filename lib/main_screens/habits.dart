import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:streamline/main_screens/progress.dart';
import 'package:streamline/main_screens/settings.dart';
import 'package:streamline/widgets/dialog_box.dart';
import 'package:streamline/widgets/habit_circle.dart';

import '../sub_screens/new_habit_screen.dart';
import '../theme/colors.dart';
import '../widgets/snackbar.dart';
import 'home.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  List habitsCircles = [
    //habit name - habit icon - habit count - habit status
    ['Read', FeatherIcons.book, 0, false],
    ['Workout', Icons.fitness_center, 0, false],
    ['Drink Water', Icons.water, 0, false],
    ['Take Creatine', Icons.fitness_center, 0, false],
  ];
  void completeHabit(int index) {
    if (habitsCircles[index][3]) {
      MyMessageHandler.showSnackBar(
          _scaffoldKey, 'Habit is already completed for the day.');
    } else {
      setState(() {
        habitsCircles[index][3] = !habitsCircles[index][3];
        habitsCircles[index][2]++;
      });
    }
  }


  final _controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/habits/background.png'),
                      fit: BoxFit.fill))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 40,
              children: List.generate(habitsCircles.length, (index) {
                return GestureDetector(
                    onLongPress: () {
                      completeHabit(index);
                    },
                    child: HabitCircle(
                      habitName: habitsCircles[index][0],
                      icon: habitsCircles[index][1],
                      habitCount: habitsCircles[index][2],
                      habitDone: habitsCircles[index][3],
                    ));
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
                backgroundColor: AppColors.orange,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => NewHabitScreen())));
                },
                elevation: 0,
                child: Icon(FeatherIcons.plus, size: 30)),
          ),
        ]),
      ),
    );
  }
}
