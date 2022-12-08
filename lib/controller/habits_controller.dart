import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../model/habit.dart';
import '../widgets/snackbar.dart';

class HabitsController extends GetxController {
  var habits = <Habit>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchHabits();
  }

  void fetchHabits() async {
    await Future.delayed(Duration(seconds: 1));
    var habitsResult = [
      Habit(
          habitName: 'Read',
          repeatDaily: 2,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Workout',
          repeatDaily: 1,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Drink water',
          repeatDaily: 3,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Take creatine',
          repeatDaily: 1,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
    ];
    habits.assignAll(habitsResult);
  }

  void completeHabit(int index, _scaffoldKey) {
    if (habits[index].completedCount == habits[index].repeatDaily) {
      MyMessageHandler.showSnackBar(
          _scaffoldKey, 'Habit is already completed for the day.');
    } else {
      habits[index].isCompleted = true;
      habits[index].completedCount++;
      update();
    }
  }

  void addHabit(Habit habit) {
    habits.add(habit);
    update();
  }

  void deleteHabit(int index) {
    habits.removeAt(index);
    update();
  }

  void setRepeat(int index, int repeatDaily) {
    habits[index].repeatDaily = repeatDaily;
    update();
  }
}
