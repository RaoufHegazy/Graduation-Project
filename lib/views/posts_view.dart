import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_post.dart';
import 'package:graduation_project/services/cloud/cloud_subject.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';
import '/utilities/generics/get_arguments.dart';
import 'posts/post_list_view.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subject = context.getArgument<CloudSubject>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createPostRoute,
                  arguments: subject,
                );
              },
              icon: const Icon(Icons.add),
            ),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                final navigator = Navigator.of(context);
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
                    if (shouldLogOut) {
                      await AuthService.firebase().logOut();
                      navigator.pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    }
                    break;
                  case MenuAction.createSection:
                    break;
                  case MenuAction.createLap:
                    break;
                  case MenuAction.createDevice:
                    break;
                  case MenuAction.createYear:
                    break;
                  case MenuAction.createSubject:
                    break;
                  case MenuAction.createPost:
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text("Log Out"),
                  ),
                ];
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: _appService.allPosts(subjectName: subject!.subjectName),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allPosts = snapshot.data as Iterable<CloudPost>;
                  return PostsListView(
                    posts: allPosts,
                    onDeleteLap: (lap) async {
                      await _appService.deletePost(documentId: lap.documentId);
                    },
                    onTap: (post) {
                      // Navigator.of(context).pushNamed(
                      //   devicesViewRoute,
                      //   arguments: lap,
                      // );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }

              default:
                return const CircularProgressIndicator();
            }
          },
        )
        //const Text("Hello"),
        );
  }
}
