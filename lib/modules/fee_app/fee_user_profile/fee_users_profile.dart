import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:v46/shared/components/components.dart';

import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';

class fee_users_profile_screen extends StatefulWidget {
  @override
  State<fee_users_profile_screen> createState() =>
      _fee_users_profile_screenState();
}

class _fee_users_profile_screenState extends State<fee_users_profile_screen> {
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  var name_controller = TextEditingController();
  var email_controller = TextEditingController();

  var id_controller = TextEditingController();

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.firebase().currentuser;
    _appService.getName(userId: user!.id).then((value) {
      name_controller.text = value;
    });
    email_controller.text = user.email;
    id_controller.text = user.id;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      TextFormField(
                        controller: name_controller,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: email_controller,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 15),

                      Material(
                        color:
                            Colors.transparent, // Set the color to transparent.
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: id_controller,
                                decoration: InputDecoration(
                                  labelText: 'id',
                                  border: OutlineInputBorder(),
                                  enabled: false,
                                ),
                                maxLines: 1,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                // Copy the contents of the text field to the clipboard.
                                Clipboard.setData(
                                    ClipboardData(text: id_controller.text));
                                scaffold_messenger(
                                    context: context, text: 'id is Copied');
                              },
                              icon: Icon(
                                Icons.copy,
                              ),
                            )
                          ],
                        ),
                      ),

                      // Copy button.
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
