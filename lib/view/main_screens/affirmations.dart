import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:streamline/constants/colors.dart';
import 'package:streamline/view/widgets/home_widgets.dart';

import '../../constants/firebase_constants.dart';
import '../../controller/affirmation_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/users_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AffirmationsScreen extends StatefulWidget {
  AffirmationsScreen({super.key});

  @override
  State<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

late String name;

AffirmationController controller = Get.find<AffirmationController>();

class _AffirmationsScreenState extends State<AffirmationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/affirmations/flowers.png'),
                          fit: BoxFit.fill))),
            ),
            Padding(
              padding: const EdgeInsets.all(34),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Text('Hello,',
                        style: TextStyle(
                            fontSize: 44, fontWeight: FontWeight.w100)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: GetX<UserController>(
                      initState: (_) async {
                        Get.find<UserController>().user = await userController
                            .getUser(Get.find<AuthController>().user.uid);
                      },
                      builder: (_) {
                        return Text(
                            (_.user.name != null ? _.user.name! : 'Human')
                                .capitalize(),
                            style: TextStyle(
                                fontSize: 44, fontWeight: FontWeight.w600));
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('This is your daily food for thought:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w100)),
                  ),
                  const SizedBox(height: 80),
                  GetBuilder<AffirmationController>(
                    initState: (_) async {
                      controller.isLoading = true;
                      await controller.fetchAffirmation();
                    },
                    builder: (controller) {
                      if (controller.isLoading) {
                        return CircularProgressIndicator();
                      } else if (controller.affirmation == '') {
                        return Container();
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.3,
                                wordSpacing: 1.2,
                                height: 1.4),
                            child: AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(controller.affirmation + '.',
                                    speed: Duration(milliseconds: 100)),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 200),
                  Center(
                    child: TextButton(
                      key: const ValueKey('ready-btn'),
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                      child: const Text('I Am Ready...',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange2)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
