import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeModel {
  final _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);

    if (xfile != null) {
      final storgeRef = FirebaseStorage.instance.ref();
      final imageRef = storgeRef.child(
          'user/${FirebaseAuth.instance.currentUser?.uid}profile/${DateTime.now().millisecondsSinceEpoch}.png');

      // 이미지 url을 얻고
      await imageRef.putFile(File(xfile.path));
      final downloadUrl = await imageRef.getDownloadURL();

      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    }
    // 이미지 업로드
  }

  String getEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ??
        'https://t1.daumcdn.net/cfile/tistory/99D1E93D5E0F738C39';
  }
}
