import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v46/modules/fee_app/fee_login/fee_login_screen.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';

// late final FirebaseCloudStorage _appService;
FirebaseCloudStorage _appService =FirebaseCloudStorage();


class fee_verify_screen extends StatefulWidget {
  final String ? user_type;
  fee_verify_screen({ this.user_type});

  @override
  State<fee_verify_screen> createState() => _fee_verify_screenState();
}

class _fee_verify_screenState extends State<fee_verify_screen> {
  @override
  void initState() {
    // object of FirebaseCloudStorage (not sure)
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/back5.jpg'))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "press to send email verificaion",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black, fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        text: 'verify',
                        function: () async {
                          // fee_verify_cubit.get(context).
                          // user_verify(
                          //     name: name_controller.text,
                          //     phone: phone_controller.text,
                          //     email: email_controller.text,
                          //     password: email_controller.text);;
                          AuthService.firebase().sendEmailVerfication();
                          scaffold_messenger(context: context, text: 'email verification sent');
                        },
                        color: Colors.lightBlueAccent,
                        font: 15),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "login if it's already verified",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black, fontSize: 35),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'Login',
                        function: () async {
                          // fee_verify_cubit.get(context).
                          // user_verify(
                          //     name: name_controller.text,
                          //     phone: phone_controller.text,
                          //     email: email_controller.text,
                          //     password: email_controller.text);;
                          navigate_to(context, fee_login_screen());
                        },
                        color: Colors.lightBlueAccent,
                        font: 15),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
