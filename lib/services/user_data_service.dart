import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:task_login_wing/model/user.dart';

class UserDataService {
  final _fireStore = FirebaseFirestore.instance.collection('users');

  Future addUserData(
      {required String uid,
      required String emailId,
      required String image,
      required String name}) async {
    await _fireStore
        .doc(uid)
        .set({'email': emailId, 'image': image, 'name': name});
  }

  List<User> userListFromSnapshot(QuerySnapshot snapshot) {
    return [
      ...snapshot.docs.map(
        (e) => User(
          email: e['email'] ?? '',
          image: e['image'] ?? '',
          name: e['name'] ?? '',
        ),
      ),
    ];
  }

  Stream<List<User>> get users {
    return _fireStore.snapshots().map(userListFromSnapshot);
  }
}
