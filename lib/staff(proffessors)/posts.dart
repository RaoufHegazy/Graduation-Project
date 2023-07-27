import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v46/modules/fee_app/fee_departments/update_department_data.dart';
import 'package:v46/modules/fee_app/fee_laps/laps.dart';
import 'package:v46/modules/fee_app/fee_search/fee_search.dart';
import 'package:v46/modules/fee_app/fee_user_profile/fee_users_profile.dart';
import 'package:v46/services(R)/cloud/cloud_post.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/staff(proffessors)/cloud_blog.dart';
import 'package:v46/students/create_Subject_data.dart';
import '../../../shared/components/menu_action.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/cloud_section.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/delete_dialog.dart';
import '../../../utilities(R)/dialogs/logout_dialog.dart';
import '../modules/fee_app/fee_departments/create_department.dart';
import '../modules/fee_app/fee_login/fee_login_screen.dart';
import '../modules/fee_app/fee_settings/labs_settings.dart';

List<TextSpan> linkify(String text) {
  final links = RegExp(r'http(s)?://[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+(/[^\s]*)?')
      .allMatches(text);

  final List<TextSpan> textSpans = [];

  int previousIndex = 0;
  for (final match in links) {
    if (match.start > previousIndex) {
      final nonLinkText = text.substring(previousIndex, match.start);
      textSpans.add(TextSpan(text: nonLinkText));
    }

    final linkText = match.group(0);
    final linkSpan = TextSpan(
      text: linkText,
      style: TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = () => _launchURL(linkText!),
    );
    textSpans.add(linkSpan);

    previousIndex = match.end;
  }

  if (previousIndex < text.length) {
    final remainingText = text.substring(previousIndex);
    textSpans.add(TextSpan(text: remainingText));
  }

  return textSpans;
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

class Professor_posts_screen extends StatefulWidget {
  final CloudUser cloud_user;
  final String? Subject_name;

  Professor_posts_screen(
      {required this.Subject_name, required this.cloud_user});

  @override
  State<Professor_posts_screen> createState() => _Professor_posts_screenState();
}

class _Professor_posts_screenState extends State<Professor_posts_screen> {
  final user = AuthService.firebase().currentuser;
  final TextEditingController _messageController = TextEditingController();

  void _addChatMessage() {
    final String message = _messageController.text;

    setState(() {
      _appService.createNewBlogPost(
          text: message,
          ownerId: widget.cloud_user.displayName,
          where: widget.Subject_name!);
      _messageController.clear();
    });
  }

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
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black), // Set the color of the leading icon
          backgroundColor: Color(0xFF87CEEB),
          title: Text(
            '${widget.Subject_name}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 16.0), // This sets a 16-pixel top margin
          child: StreamBuilder(
            stream: _appService.getBlogPosts(where: widget.Subject_name!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final posts = snapshot.data as Iterable<CloudBlog>;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: posts.length,
                          separatorBuilder: (context, index) {
                            return Column(
                              children: [
                                divider(),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          },
                          itemBuilder: (context, index) {
                            var post = posts.elementAt(index);
                            if (widget.cloud_user.title == 'Professor') {
                              return Container(
                                color: Colors.grey[100],
                                child: ListTile(
                                  title: Text('${post.ownerId}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      )),
                                  subtitle: SelectableText.rich(
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(fontSize: 16.0),
                                      children: linkify(post.text),
                                    ),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final shouldDelete =
                                              await showDeleteDialog(context);
                                          if (shouldDelete) {
                                            await _appService.deleteBlogPost(
                                                documentId: post.documentId);
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                color: Colors.grey[100],
                                child: ListTile(
                                  title: Text('${post.ownerId}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      )),
                                  subtitle: SelectableText.rich(
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(fontSize: 16.0),
                                      children: linkify(post.text),
                                    ),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Default_Text_Form_Field(
                                type: TextInputType.text,
                                controller: _messageController,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  _addChatMessage();
                                },
                                child: Icon(
                                  Icons.arrow_circle_right,
                                  size: 50,
                                )),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(child: Text('No posts'));
                }
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
