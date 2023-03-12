import 'package:flutter/material.dart';
import '/services/cloud/cloud_post.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/views/posts/post_list_view.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  //late final FirebaseCloudStorage _appService;
  String get userId => AuthService.firebase().currentuser!.id;

  // @override
  // void initState() {
  //   _appService = FirebaseCloudStorage();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainUI"),
        centerTitle: true,
        actions: [
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
      body:
          // StreamBuilder(
          //   stream: _appService.allPosts(ownerUserId: userId),
          //   builder: (context, snapshot) {
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.waiting:
          //       case ConnectionState.active:
          //         if (snapshot.hasData) {
          //           final allPosts = snapshot.data as Iterable<CloudPost>;
          //           return PostsListView(
          //             posts: allPosts,
          //             onDeletePost: (post) async {
          //               await _appService.deletePost(documentId: post.documentId);
          //             },
          //             onTap: (post) {
          //               Navigator.of(context).pushNamed(
          //                 createOrUpdatePostRoute,
          //                 arguments: post,
          //               );
          //             },
          //           );
          //         } else {
          //           return const CircularProgressIndicator();
          //         }

          //       default:
          //         return const CircularProgressIndicator();
          //     }
          //   },
          // )
          const Text("Hello"),
    );
  }
}
