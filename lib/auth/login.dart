import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streamline/widgets/auth_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:streamline/widgets/snackbar.dart';




class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String _uid;
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
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/affirmations');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'No user found with that email.');
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(_scaffoldKey, 'Wrong password.');
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Container(
        child: Scaffold(
            backgroundColor: const Color(0xFFFF6E50),
            body: SafeArea(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                reverse: true,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'StreamLine',
                          style: TextStyle(color: Colors.orange, fontSize: 30),
                        ),
                        const SizedBox(height: 47),
                        const Text('Log In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your email ';
                                    } else if (value.isValidEmail() == false) {
                                      return 'invalid email';
                                    } else if (value.isValidEmail() == true) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    email = value;
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
                                    password = value;
                                  },
                                  obscureText: passwordVisible,
                                  decoration: textFormDecoration.copyWith(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            passwordVisible
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
                              ? Center(child: CircularProgressIndicator(color: Colors.white))
                              : AuthButton(
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
                                    Navigator.pushReplacementNamed(
                                        context, '/sign_up');
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
            )),
      ),
    );
  }
}
