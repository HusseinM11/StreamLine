import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/firebase_constants.dart';
import 'package:streamline/view/widgets/auth_widgets.dart';

import '../../constants/colors.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String name;
  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  void logIn() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      authController.login(email: email, password: password);

      
      setState(() {
        processing = false;
      });
    } else {
      setState(() {
        processing = false;
      });
      Get.snackbar('Please fill all fields.', 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        
          backgroundColor:AppColors.bg2,
          body: Stack(
            children: [ 
              Positioned(
                    bottom: -250,
                    right: -200,
                    left: -200,
                    child: Image.asset('assets/images/login/background.png')),
              SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'StreamLine',
                                style: TextStyle(
                                    color: AppColors.orange2,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 280),
                              const Text('Log In',
                              key: ValueKey('login-text'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontWeight: FontWeight.w800)),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.only( left :15.0, right: 15),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      child: TextFormField(
                                        key: const ValueKey('emailLogin-field'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your email ';
                                          } else if (value.isValidEmail() ==
                                              false) {
                                            return 'invalid email';
                                          } else if (value.isValidEmail() == true) {
                                            return null;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          email = value.trim();
                                        },
                                        //  controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: textFormDecoration.copyWith(
                                          labelText: 'Email Address',
                                          hintText: 'Enter your email',
                                          icon: const Icon(Icons.email,
                                              color: Color(0xFFFDEAC1)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      child: TextFormField(
                                        key: const ValueKey('passwordLogin-field'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your password';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          password = value.trim();
                                        },
                                        obscureText: !passwordVisible,
                                        decoration: textFormDecoration.copyWith(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    passwordVisible =
                                                        !passwordVisible;
                                                  });
                                                },
                                                icon: Icon(
                                                  !passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: const Color(0xFFFDEAC1),
                                                )),
                                            labelText: 'Password',
                                            hintText: 'Enter your password',
                                            icon: const Icon(
                                              Icons.vpn_key,
                                              color: Color(0xFFFDEAC1),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: processing == true
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white))
                                    : AuthButton(
                                      key: const ValueKey('submitLogin-btn'),
                                        label: 'Log in',
                                        onPressed: () {
                                          logIn();
                                        },
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.toNamed('/sign_up');
                                        },
                                        child: const Text(
                                          'Register here',
                                          style: TextStyle(
                                              color: Color(0xFF312B26),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

