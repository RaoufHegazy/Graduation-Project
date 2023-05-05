import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/utilities/generics/check.dart';
import 'package:graduation_project/views/devices/create_device.dart';
import 'package:graduation_project/views/devices_view.dart';
import 'package:graduation_project/views/laps/create_lap.dart';
import 'package:graduation_project/views/laps_view.dart';
import 'package:graduation_project/views/posts/create_post.dart';
import 'package:graduation_project/views/posts_view.dart';
import 'package:graduation_project/views/sections/create_section.dart';
import 'package:graduation_project/views/subjects/create_subject.dart';
import 'package:graduation_project/views/subjects_view.dart';
import 'package:graduation_project/views/years/create_year.dart';
import 'package:graduation_project/views/years_view.dart';
import '/constants/routes.dart';
import '/views/login_view.dart';
import 'firebase_options.dart';
import 'views/sections_view.dart';
import '/views/register_view.dart';
import '/views/verfiy_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
      routes: {
        check: (context) => const Check(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verfiyEmailRoute: (context) => const VerfiyEmailView(),
        sectionsViewRoute: (context) => const SectionsView(),
        createSectionRoute: (context) => const CreateSectionView(),
        lapsViewRoute: (context) => const LapsView(),
        createLapRoute: (context) => const CreateLapView(),
        devicesViewRoute: (context) => const DevicesView(),
        createDeviceRoute: (context) => const CreateDeviceView(),
        yearsViewRoute: (context) => const YearsView(),
        createYearRoute: (context) => const CreateYearView(),
        subjectsViewRoute: (context) => const SubjectsView(),
        createSubjectRoute: (context) => const CreateSubjectView(),
        postsViewRoute: (context) => const PostsView(),
        createPostRoute: (context) => const CreatePostView(),
      },
    );
  }
}
