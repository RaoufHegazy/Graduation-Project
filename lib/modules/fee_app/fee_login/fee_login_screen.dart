import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v46/modules/fee_app/fee_departments/departments.dart';
import 'package:v46/modules/fee_app/fee_login/cubit_fee_login/fee_login_cubit.dart';
import 'package:v46/modules/fee_app/fee_login/cubit_fee_login/fee_login_states.dart';
import 'package:v46/modules/fee_app/fee_verify_email/fee_verify_email.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/auth/auth_exceptions.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/cloud_user.dart';
import '../../../students/departments.dart';
import '../../../students/home_page.dart';
import '../../../utilities(R)/dialogs/error_dialog.dart';
import '../fee_on_boarding/fee_on_boarding_screen.dart';
import '../fee_register/fee_register_screen.dart';

var email_controller = TextEditingController();
var password_controller = TextEditingController();
late Widget start_widget;

var form_key = GlobalKey<FormState>();

class fee_login_screen extends StatefulWidget {
  @override
  State<fee_login_screen> createState() => _fee_login_screenState();
}

class _fee_login_screenState extends State<fee_login_screen> {
  bool is_loading = false;
  // login_methods and exception in one method
  Future<void> login_meth() async {
    setState(() {
      is_loading = true;
    });

    try {
      // authenticate login
      await AuthService.firebase().logIn(
        email: email_controller.text,
        password: password_controller.text,
      );

      final user = AuthService.firebase().currentuser;
      if (user?.isEmailVerified ?? false) {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.id)
            .get();

        CloudUser cloud_user = CloudUser.fromSnapshot(userSnapshot);

        if (cloud_user.title == 'Student') {
          navigate_and_finish(
              context,
              student_HomePage(
                cloud_user: cloud_user,
              ));
        } else if (cloud_user.title == 'Worker') {
          navigate_and_finish(
              context,
              departments(
                cloud_user: cloud_user,
              ));
        } else if (cloud_user.title == 'Professor') {
          navigate_and_finish(
              context,
              Departments(
                cloud_user: cloud_user,
              ));
        }

        // navigate_and_finish(context, departments(user_type: UserType,));
      } else {
        navigate_and_finish(context, fee_verify_screen());
      }
    } on UserNotFoundAuthException {
      setState(() {
        is_loading = false;
      });

      await showErrorDialog(
        context,
        "User Not Found",
      );
    } on WrongPasswordAuthException {
      setState(() {
        is_loading = false;
      });

      await showErrorDialog(
        context,
        "Wrong Password",
      );
    } on GnericAuthException {
      setState(() {
        is_loading = false;
      });

      await showErrorDialog(
        context,
        "Authintication Error",
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  // void dispose() {
  //   email_controller.dispose();
  //   password_controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => fee_login_cubit(),
      child: BlocConsumer<fee_login_cubit, fee_login_states>(
        listener: (context, state) {
          // if (state is fee_login_success_state) {
          //   navigate_and_finish(context, fee_layout_screen());
          //
          //   flutter_toast(
          //       message: 'Logged in successfully', state: toast_state.SUCCESS);
          // }
        },
        builder: (context, state) {
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
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Form(
                        key: form_key,
                        child: SafeArea(
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black, fontSize: 35),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Default_Text_Form_Field(
                                type: TextInputType.emailAddress,
                                controller: email_controller,
                                label_text: 'Email Address',
                                prefix: Icon(Icons.email_outlined),
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'please enter your email';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Default_Text_Form_Field(
                                  type: TextInputType.visiblePassword,
                                  controller: password_controller,
                                  label_text: 'Password',
                                  prefix: Icon(Icons.lock),
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'please enter your password';
                                    }
                                  },
                                  SuffixPressed: () {
                                    fee_login_cubit
                                        .get(context)
                                        .fee_login_change_visibility_password();
                                  },
                                  ispassword:
                                      fee_login_cubit.get(context).is_password,
                                  suffix: fee_login_cubit.get(context).suffix,
                                  onfield: (value) {
                                    if (form_key.currentState!.validate()) {
                                      login_meth();
                                      // fee_login_cubit.get(context).user_login(
                                      //     email: email_controller.text,
                                      //     password: password_controller.text
                                      // );
                                    }
                                  }),
                              SizedBox(
                                height: 35,
                              ),
                              is_loading
                                  ? CircularProgressIndicator()
                                  : defaultButton(
                                      text: 'LOGIN',
                                      function: () async {
                                        if (form_key.currentState!.validate()) {
                                          // fee_login_cubit.get(context).user_login(
                                          //     email: email_controller.text,
                                          //     password: password_controller.text);
                                          login_meth();
                                        }
                                      },
                                      color: Colors.lightBlueAccent,
                                      font: 15),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't Have An Account?",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  default_text_button(
                                      function: () {
                                        navigate_to(
                                            context, fee_register_screen());
                                      },
                                      text: 'Register now',
                                      color: Colors.lightBlueAccent,
                                      font: 18)
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                color: Color(0xfffbe4d8),
                                child: TextButton(
                                  onPressed: () {
                                    is_last = false;
                                    navigate_and_finish(
                                        context, fee_on_boarding_screen());
                                  },
                                  child: Text('BIOGRAPHY ABOUT THE APP',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontFamily: 'angelina',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
