import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:streamline/widgets/home_widgets.dart';

class AffirmationsScreen extends StatefulWidget {
  final String documentId;

  const AffirmationsScreen({super.key, required this.documentId});

  @override
  State<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

late String name;


class _AffirmationsScreenState extends State<AffirmationsScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          name = data['name'];
          
          return Scaffold(
              backgroundColor: const Color(0xFFFDEAC1),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'images/affirmations/flowers.png'),
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
                          child: Text('$name!'.capitalize(),
                              style: TextStyle(
                                  fontSize: 44, fontWeight: FontWeight.w600)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('This is your daily afirmation:',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w100)),
                        ),
                        const SizedBox(height: 80),
                        const Text(
                            'Through the power of my thoughts and words, incredible transformations are happening in me and within my life right now.',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 200),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            child: const Text('I Am Ready...',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFF6E50))),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ));
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFF6E50),
          ),
        );
        ;
      },
    );
  }
}

