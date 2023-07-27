import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:v46/students/tracks.dart';
import 'package:v46/students/widgets/folder.dart';

import '../modules/fee_app/fee_login/fee_login_screen.dart';
import '../modules/fee_app/fee_user_profile/fee_users_profile.dart';
import '../services(R)/auth/auth_service.dart';
import '../services(R)/cloud/cloud_user.dart';
import '../shared/components/components.dart';
import '../utilities(R)/dialogs/logout_dialog.dart';
import 'CS_levels.dart';
import 'constants.dart';
import 'departments/communication.dart';
import 'departments/computerScience.dart';
import 'departments/control.dart';
import 'departments/credit.dart';
import 'faculty_rules.dart';
import 'home_page.dart';

class Departments extends StatefulWidget {
  final CloudUser cloud_user;

  Departments({required this.cloud_user});

  // final String user_type;
  // Departments({required this.user_type});

  @override
  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  final user = AuthService.firebase().currentuser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("Departments"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                navigate_to(context, fee_users_profile_screen());
              },
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                IconlyBold.logout,
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () async {
                var sure_logout = await showLogOutDialog(context);
                if (sure_logout) {
                  await AuthService.firebase().logOut();
                  navigate_and_finish(context, fee_login_screen());
                }
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                  backgroundImage: "images/cs.jpg",
                  name: "Computer Science",
                  where: ComputerScience(cloud_user: widget.cloud_user),
                  textColor: Colors.white,
                ),
                Folder(
                  backgroundImage: "images/com.jpg",
                  name: "Communication",
                  where: Communication(cloud_user: widget.cloud_user),
                  textColor: Colors.black,
                ),
              ],
            ),
            Folder(
              backgroundImage: "images/0.jpg",
              name: "Prep Year",
              where: Levels(level: "Prep Year", cloud_user: widget.cloud_user),
              textColor: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                  backgroundImage: "images/control.jpg",
                  name: "Control",
                  where: Control(cloud_user: widget.cloud_user),
                  textColor: Colors.black,
                ),
                Folder(
                  backgroundImage: "images/credit.jpg",
                  name: "Credit",
                  where: Credit(cloud_user: widget.cloud_user),
                  textColor: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        height: 50,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Text("Rules"),
          Text("Tracks"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return student_HomePage(
                  cloud_user: widget.cloud_user,
                );
              }),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return FacultyRules();
              }),
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Tracks();
            }));
          }
        },
      ),
    );
  }
}
