import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:streamline/view/main_screens/progress.dart';
import 'package:streamline/view/widgets/report_sheet.dart';

import '../../constants/colors.dart';
import '../../constants/firebase_constants.dart';
import '../widgets/edit_profile.dart';
import 'habits.dart';
import 'home.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg2,
      appBar: AppBar(
        backgroundColor: AppColors.bg2,
        elevation: 0,
        //remove the back action
        automaticallyImplyLeading: false,
        title: const Text('Settings',
            style: TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w600,
                fontSize: 22)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/habits/settingsbg.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('General',
                    style: TextStyle(
                      color: AppColors.darkGrey.withOpacity(0.8),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 20),
                SettingsTiles(
                  label: 'Account',
                  icon: FontAwesomeIcons.user,
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    isScrollControlled: true,
                      builder: (BuildContext context) {
                        return  Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: EditProfileSheet(),
                        );
                      }),
                ),
                const LightGreyDivider(),
                SettingsTiles(
                  label: 'Log Out',
                  icon: FontAwesomeIcons.signOut,
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('Sign Out'),
                        content: Text('Are you sure you want to sign out?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () => Get.back(),
                          ),
                          CupertinoDialogAction(
                            textStyle: TextStyle(color: Colors.red),
                            child: Text('Sign Out'),
                            onPressed: () => authController.signOut(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const LightGreyDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NotificationsSwitch(),
                    Switch(
                      activeColor: AppColors.orange2,
                      value: notifications,
                      onChanged: (bool value) {
                        setState(() {
                          notifications = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Feedback',
                    style: TextStyle(
                      color: AppColors.darkGrey.withOpacity(0.8),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 20),
                SettingsTiles(
                  label: 'Report a bug',
                  icon: FontAwesomeIcons.penToSquare,
                  onPressed: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding:MediaQuery.of(context).viewInsets,
                          child: ReportSheet(),
                        );
                      }),
                ),
              ]),
        ),
      ),
    );
  }
}

class NotificationsSwitch extends StatelessWidget {
  const NotificationsSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.message,
          size: 18,
          color: AppColors.darkGrey,
        ),
        const SizedBox(width: 30),
        const Text('Notifications',
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}

class SettingsTiles extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onPressed;
  const SettingsTiles(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.darkGrey,
            ),
            const SizedBox(width: 30),
            Text(label,
                style: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleRight,
            size: 18,
            color: AppColors.darkGrey,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class LightGreyDivider extends StatelessWidget {
  const LightGreyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      thickness: 0.8,
      color: Colors.black.withOpacity(0.3),
    );
  }
}
