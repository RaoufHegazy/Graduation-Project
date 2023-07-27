import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v46/shared/bloc_observer.dart';
import 'package:v46/shared/network/local/cache_helper.dart';
import 'package:v46/shared/styles/theme.dart';
import 'modules/fee_app/fee_splash/fee_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();
  await cache_helper.init();

  //get data from cache
  var on_boarding = cache_helper.get_data(key: 'on_boarding');

  runApp(app(on_boarding));
}

class app extends StatelessWidget {
  // final Widget start_wiget;
  final on_boarding ;

  app(this.on_boarding);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightmode,
      darkTheme: darkmode,
      home:fee_splash_screen(on_boarding: on_boarding ?? false,),
    );
  }
}
