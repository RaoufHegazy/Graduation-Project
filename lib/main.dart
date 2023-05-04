import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/views/laps/create_lap.dart';
import 'package:graduation_project/views/laps_view.dart';
import 'package:graduation_project/views/sections/create_section.dart';
import '/services/auth/auth_service.dart';
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
        homeRoute: (context) => const HomePage(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        sectionsViewRoute: (context) => const SectionsView(),
        verfiyEmailRoute: (context) => const VerfiyEmailView(),
        createSectionRoute: (context) => const CreateSectionView(),
        lapsViewRoute: (context) => const LapsView(),
        createLapRoute: (context) => const CreateLapView(),
        // createOrUpdatePostRoute: (context) => const CreateUpdatePostView(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = AuthService.firebase().currentuser;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      if (user!.isEmailVerified) {
        return const SectionsView();
      } else {
        return const VerfiyEmailView();
      }
    } else {
      return const LoginView();
    }
  }
}
