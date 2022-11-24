import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:streamline/data/categ_list.dart';

import '../theme/colors.dart';
import '../widgets/snackbar.dart';

class NewHabitScreen extends StatefulWidget {
  const NewHabitScreen({super.key});

  @override
  State<NewHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  late String title;
  late String description;
  int repeat = 1;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
          backgroundColor: AppColors.bg2,
          body: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/habits/addhabit.png'),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  FlutterIconPicker.showIconPicker(context,
                                      iconPackModes: [IconPack.fontAwesomeIcons]);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                          CupertinoIcons
                                              .arrowtriangle_down_square,
                                          size: 60,
                                          color: AppColors.orange2),
                                    )),
                              ),
                              Text('Choose icon',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGrey))
                            ],
                          ),
                        ),
                        const Text('Details',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 15),
                        const Text('Title',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w300)),
                        TextFormField(
                          style: const TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          decoration: const InputDecoration(
                              hintText: 'Go to the gym',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter a title for the habit.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        const Text('Description',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w300)),
                        TextFormField(
                          style: const TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          decoration: const InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              )),
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 45,
                          child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColors.darkGrey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                  onPressed: () {
                                    
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(categories[index],
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Schedule',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        Container(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: days.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColors.darkGrey,
                                    shape: const CircleBorder()),
                                onPressed: () {},
                                child: Text(days[index],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[400],
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        if (repeat == 1) {
                                          MyMessageHandler.showSnackBar(
                                              _scaffoldKey,
                                              'Cannot decrease less than 1.');
                                        } else if (repeat >= 1){
                                          repeat--;
                                        } 
                                      });
                                    },
                                    icon: const Icon(FeatherIcons.minus,
                                        color: Colors.white, size: 20))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$repeat',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Time a day',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green[400],
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        repeat++;
                                      });
                                    },
                                    icon: const Icon(FeatherIcons.plus,
                                        color: Colors.white, size: 20))),
                          ],
                        ),
                        const SizedBox(height: 75),
                        Align(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: AppColors.orange2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 5),
                                child: const Text('Save habit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30)),
                              )),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
