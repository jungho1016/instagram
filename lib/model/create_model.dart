import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/post.dart';

class CreateModel {
  final _pikier = ImagePicker();

  Future<File?> getImage() async {
    final XFile? image = await _pikier.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return File(image.path);
  }

  Future<void> uploadPost(String title, File imageFile) async {
    // 이미지 업로드
    final storgeRef = FirebaseStorage.instance.ref();
    final imageRef = storgeRef
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}.png');

    // 이미지 url을 얻고
    await imageRef.putFile(imageFile);
    final downloadUrl = await imageRef.getDownloadURL();

    // 게시물 업로드

    final postsRef =
        FirebaseFirestore.instance.collection('posts').withConverter<Post>(
              fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
              toFirestore: (post, _) => post.toJson(),
            );

    final newPostRef = postsRef.doc();
    newPostRef.set(
      Post(
        id: newPostRef.id,
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        title: title,
        imageUrl: downloadUrl,
      ),
    );
  }
}
