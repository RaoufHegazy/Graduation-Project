// import 'package:flutter/material.dart';
// import '/services/cloud/cloud_post.dart';
// import '/utilities/dialogs/delete_dialog.dart';

// typedef PostCallback = void Function(CloudPost post);

// class PostsListView extends StatelessWidget {
//   final Iterable<CloudPost> posts;
//   final PostCallback onDeletePost;
//   final PostCallback onTap;

//   const PostsListView(
//       {super.key,
//       required this.posts,
//       required this.onDeletePost,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts.elementAt(index);
//         return ListTile(
//           onTap: () {
//             onTap(post);
//           },
//           title: Text(
//             post.text,
//             maxLines: 1,
//             softWrap: true,
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: IconButton(
//             onPressed: () async {
//               final shouldDelete = await showDeleteDialog(context);
//               if (shouldDelete) {
//                 onDeletePost(post);
//               }
//             },
//             icon: const Icon(Icons.delete),
//           ),
//         );
//       },
//     );
//   }
// }
