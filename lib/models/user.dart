import 'package:cloud_firestore/cloud_firestore.dart';

class USER {
  final String displayName;
  final String email;
  final String userId;
  final String profilePhoto;
  final String key;
  final String gender;
  final String profilePhotoId;
  final List<dynamic> userCart;
  USER({
    this.displayName,
    this.email,
    this.userId,
    this.profilePhoto,
    this.key,
    this.gender,
    this.profilePhotoId,
    this.userCart,
  });

  factory USER.fromDocument(DocumentSnapshot doc) {
    var docu = doc;
    return USER(
      displayName: docu['displayName'] ?? " ",
      email: docu['email'] ?? " ",
      userId: docu['userId'] ?? " ",
      profilePhoto: docu['profilePhoto'] ?? " ",
      key: docu['key'] ?? " ",
      gender: docu['gender'] ?? " ",
      profilePhotoId: docu['profilePhotoId'] ?? " ",
      userCart: docu['userCart'] ?? [],
    );
  }
}
