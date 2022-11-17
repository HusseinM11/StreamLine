import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              children: [
                Positioned(
                    bottom: -250,
                    right: -200,
                    left: -200,
                    child: Image.asset('images/welcome_screen/background.png')),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'StreamLine',
                        style: TextStyle(color: Colors.orange, fontSize: 30),
                      ),
                      const SizedBox(height: 180),
                      Column(
                        children: const [
                          Text('Remove All',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.w800)),
                          Text('Distractions.',
                              style: TextStyle(
                                  color: Color(0xFFFDEAC1),
                                  fontSize: 60,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(height: 15),
                          Text(
                              textAlign: TextAlign.center,
                              'Track your daily activities and habits to better manage your life and, be better!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            AuthButton(
                              label: 'Log in',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/log_in');
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/sign_up');
                                },
                                // ignore: sort_child_properties_last
                                child: const Text('Create an account',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500)),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(
                                      width: 2, color: Color(0xFF312B26)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
