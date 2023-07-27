import 'package:flutter/material.dart';

import '../services(R)/auth/auth_service.dart';
import '../services(R)/cloud/cloud_user.dart';
import '../services(R)/cloud/firebase_cloud_storage.dart';
import 'constants.dart';
import 'encourage.dart';

class student_HomePage extends StatefulWidget {
  final CloudUser cloud_user;
  student_HomePage({required this.cloud_user});

  @override
  State<student_HomePage> createState() => _student_HomePageState();
}

class _student_HomePageState extends State<student_HomePage> {
  final user = AuthService.firebase().currentuser;

  // late final FirebaseCloudStorage _appService; give error
  FirebaseCloudStorage _appService = FirebaseCloudStorage();
  var form_key = GlobalKey<FormState>();
  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kprimaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 105,
              backgroundColor: Color.fromARGB(255, 255, 98, 98),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                child: Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('images/feeee.png'),
                ),
              ),
            ),
            const Text(
              'FEE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const Divider(
              thickness: 5,
              color: Color.fromARGB(255, 105, 198, 235),
              indent: 50,
              endIndent: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '         مرحبا بكم في كلية الهندسة الالكترونية بمنوف',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Encouragement(
                            cloud_user: widget.cloud_user,
                          )),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
