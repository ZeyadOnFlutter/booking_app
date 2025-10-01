import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

abstract class FirebaseAuthDataSource {
  CollectionReference<UserModel> getUserCollection();
  Future<UserModel?> register(String name, String email, String password, String phone);
  Future<UserModel?> login(String email, String password);
  Future<UserModel> getUserFromFireStore(UserModel user);
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithFacebook();
  Future<void> addUserToFireStore(UserModel user);
  Future<void> logout();
}
