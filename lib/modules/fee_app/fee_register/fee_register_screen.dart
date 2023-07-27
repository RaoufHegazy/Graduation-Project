import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/auth/auth_exceptions.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/error_dialog.dart';
import '../fee_verify_email/fee_verify_email.dart';
import 'fee_register_cubit/fee_register_cubit.dart';
import 'fee_register_cubit/fee_register_states.dart';

// late final FirebaseCloudStorage _appService; give an error
FirebaseCloudStorage _appService = FirebaseCloudStorage();

class fee_register_screen extends StatefulWidget {
  @override
  State<fee_register_screen> createState() => _fee_register_screenState();
}

class _fee_register_screenState extends State<fee_register_screen> {
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  final form_key = GlobalKey<FormState>();

  var name_controller = TextEditingController();
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();

// drop down search
  var professor_password_controller = TextEditingController();

  List<String> user_type_list = ['Professor', 'Student', 'Worker'];
  List<String> student_years_list = ['Preparatory', '1st', '2nd', '3rd', '4th'];
  List<String> student_departments_list = [
    'Computer Science',
    'Control',
    'Communication',
    'Credit'
  ];

  String user_type = '';
  String student_year = '';
  String student_department = '';

  @override
  // circular progress indicator when logging in
  bool is_loading = false;

// all functions and exceptions used when registering created in one method(register_meth)
  Future<void> register_meth(context,
      {required String user_type,
      String? student_year,
      String? student_department}) async {
    setState(() {
      is_loading = true; // when is loading is true circular progress will on
    });
    try {
      // make authentication for user
      await AuthService.firebase().createUser(
        email: email_controller.text,
        password: password_controller.text,
      );
      // send verification for email
      AuthService.firebase().sendEmailVerfication();
      scaffold_messenger(context: context, text: 'email verification sent');

      final user = AuthService.firebase().currentuser;

      // create user in firestore
      await _appService.createNewUser(
        id: user!.id,
        email: email_controller.text,
        title: user_type,
        name: name_controller.text,
        student_year: student_year,
        student_dapartment: student_department,
      );

      navigate_and_finish(
          context,
          fee_verify_screen(
            user_type: user_type,
          ));
    } on WeakPasswordAuthException {
      setState(() {
        is_loading = false;
      });
      await showErrorDialog(
        context,
        "Weak password",
      );
    } on EmailAlreadyInUseAuthException {
      setState(() {
        is_loading = false;
      });
      await showErrorDialog(
        context,
        "Email already in use",
      );
    } on InvalidEmailAuthException {
      setState(() {
        is_loading = false;
      });

      await showErrorDialog(
        context,
        "Invalid email",
      );
    } on GnericAuthException {
      await showErrorDialog(
        context,
        "Error",
      );
    }
  }

  void initState() {
    // object of FirebaseCloudStorage (not sure)
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  // give error
  // @override
  // void dispose() {
  //   email_controller.dispose();
  //   password_controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String? password;
    _appService.get_professor_Password().then((value) {
      password = value!;
    });

    return BlocProvider(
      create: (BuildContext context) => fee_register_cubit(),
      child: BlocConsumer<fee_register_cubit, fee_register_states>(
        listener: (context, state) {
          // if (state is fee_create_user_success_state) {
          //   navigate_and_finish(context, fee_login_screen());
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
                    child: Form(
                      key: form_key,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black, fontSize: 35),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Default_Text_Form_Field(
                            type: TextInputType.name,
                            controller: name_controller,
                            label_text: ' Name',
                            prefix: Icon(Icons.drive_file_rename_outline),
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
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
                              return null;
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
                                return null;
                              },
                              SuffixPressed: () {
                                fee_register_cubit
                                    .get(context)
                                    .fee_register_change_visibility_password();
                              },
                              ispassword:
                                  fee_register_cubit.get(context).is_password,
                              suffix: fee_register_cubit.get(context).suffix,
                              onfield: (value) {
                                // if (form_key.currentState!.validate()) {
                                //   fee_register_cubit.get(context).user_register(
                                //       email: email_controller.text,
                                //       password: password_controller.text);
                                // }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          drop_down_search(
                            selected_item: user_type,
                            selected_list: user_type_list,
                            message: 'Please Select Your Role',
                            function: (value) {
                              setState(() {
                                user_type = value!;
                              });
                            },
                            label_text: 'Select Your Role',
                          ),
                          if ((user_type == 'Student')) ...[
                            SizedBox(
                              height: 15,
                            ),
                            drop_down_search(
                              selected_item: student_year,
                              selected_list: student_years_list,
                              message: 'Please Select Your Year',
                              function: (value) {
                                setState(() {
                                  student_year = value!;
                                });
                              },
                              label_text: 'Select Your Year',
                            ),
                            if (!(student_year == 'Preparatory')) ...[
                              SizedBox(
                                height: 20,
                              ),
                              drop_down_search(
                                selected_item: student_department,
                                selected_list: student_departments_list,
                                message: 'Please Select Your Department',
                                function: (value) {
                                  setState(() {
                                    student_department = value!;
                                  });
                                },
                                label_text: 'Select Your Department',
                              ),
                            ]
                          ] else if (user_type == 'Professor') ...[
                            SizedBox(
                              height: 20,
                            ),
                            Default_Text_Form_Field(
                                type: TextInputType.visiblePassword,
                                controller: professor_password_controller,
                                label_text: 'Professor key',
                                prefix: Icon(Icons.lock),
                                validate: (value) {
                                  if (value != '${password}') {
                                    return 'Password Is Wrong ';
                                  } else if (value.isEmpty) {
                                    return 'Plesae Enter Your Password';
                                  }
                                  return null;
                                },
                                ispassword: true),
                          ],
                          SizedBox(
                            height: 35,
                          ),
                          is_loading
                              ? CircularProgressIndicator()
                              : defaultButton(
                                  text: 'REGISTER',
                                  function: () {
                                    if (form_key.currentState!.validate()) {
                                      register_meth(context,
                                          user_type: user_type,
                                          student_year: student_year,
                                          student_department:
                                              student_department);
                                    }
                                  },
                                  color: Colors.lightBlueAccent,
                                  font: 15),
                        ],
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
