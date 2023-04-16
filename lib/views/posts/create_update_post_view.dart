// import 'package:flutter/material.dart';
// import '/services/auth/auth_service.dart';
// import '/services/cloud/cloud_post.dart';
// import '/services/cloud/firebase_cloud_storage.dart';
// import '/utilities/generics/get_arguments.dart';

// class CreateUpdatePostView extends StatefulWidget {
//   const CreateUpdatePostView({super.key});

//   @override
//   State<CreateUpdatePostView> createState() => _CreateUpdatePostViewState();
// }

// class _CreateUpdatePostViewState extends State<CreateUpdatePostView> {
//   CloudPost? _post;
//   late final FirebaseCloudStorage _appService;
//   late final TextEditingController _textController;

//   @override
//   void initState() {
//     _appService = FirebaseCloudStorage();
//     _textController = TextEditingController();
//     super.initState();
//   }

//   void _textControllerListener() async {
//     final post = _post;
//     if (post == null) {
//       return;
//     }
//     final text = _textController.text;
//     await _appService.updatePost(
//       documentId: post.documentId,
//       text: text,
//     );
//   }

//   void _setupTextControllerListener() {
//     _textController.removeListener(_textControllerListener);
//     _textController.addListener(_textControllerListener);
//   }

//   Future<CloudPost> createOrGetExistingPost(BuildContext context) async {
//     final widgetPost = context.getArgument<CloudPost>();
//     if (widgetPost != null) {
//       _post = widgetPost;
//       _textController.text = widgetPost.text;
//       return widgetPost;
//     }

//     final existingPost = _post;
//     if (existingPost != null) {
//       return existingPost;
//     }
//     final currentUser = AuthService.firebase().currentuser!;
//     final userId = currentUser.id;
//     final newPost = await _appService.createNewPost(ownerUserId: userId);
//     _post = newPost;
//     return newPost;
//   }

//   void _deletePostIfTextIsEmpty() {
//     final post = _post;
//     if (_textController.text.isEmpty && post != null) {
//       _appService.deletePost(documentId: post.documentId);
//     }
//   }

//   void _savePostIfTextNotEmpty() async {
//     final post = _post;
//     final text = _textController.text;
//     if (text.isNotEmpty && post != null) {
//       await _appService.updatePost(
//         documentId: post.documentId,
//         text: text,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _deletePostIfTextIsEmpty();
//     _savePostIfTextNotEmpty();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Post"),
//         centerTitle: true,
//       ),
//       body: FutureBuilder(
//         future: createOrGetExistingPost(context),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               _setupTextControllerListener();
//               return TextField(
//                 controller: _textController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(hintText: "Type here..."),
//               );
//             default:
//               return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
