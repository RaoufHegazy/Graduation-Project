import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v46/services(R)/cloud/cloud_post.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/students/create_Subject_data.dart';
import '../../../shared/components/menu_action.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/delete_dialog.dart';
import '../staff(proffessors)/posts.dart';

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

class subject_data_screen extends StatefulWidget {
  final CloudUser cloud_user;
  final String? Subject_name;

  subject_data_screen({required this.Subject_name, required this.cloud_user});

  @override
  State<subject_data_screen> createState() => _subject_data_screenState();
}

class _subject_data_screenState extends State<subject_data_screen> {
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
          actions: [
            IconButton(
                onPressed: () {
                  navigate_to(
                      context,
                      Professor_posts_screen(
                        Subject_name: widget.Subject_name,
                        cloud_user: widget.cloud_user,
                      ));
                },
                icon: Icon(Icons.post_add)),
            PopupMenuButton<MenuAction>(
              color: Colors.white,
              itemBuilder: (context) => [
                if (widget.cloud_user.title == 'Professor')
                  PopupMenuItem(
                    child: Text('Add New Post'),
                    value: MenuAction.createPost,
                  ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.createPost:
                    navigate_to(
                        context,
                        create_Subject_data_screen(
                            subject_name: widget.Subject_name,
                            cloud_user: widget.cloud_user));
                    break;
                }
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 16.0), // This sets a 16-pixel top margin
          child: StreamBuilder(
            stream: _appService.allPosts(subjectName: widget.Subject_name!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final posts = snapshot.data as Iterable<CloudPost>;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                        await _appService.deletePost(
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
