import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/firebase_error_handler.dart';
import '../../models/user_model.dart';
import 'firebase_auth_data_source.dart';

@LazySingleton(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  const FirebaseAuthDataSourceImpl(this._auth, this._firestore);
  @override
  CollectionReference<UserModel> getUserCollection() {
    return _firestore.collection('users').withConverter(
          fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  @override
  Future<void> addUserToFireStore(UserModel user) async {
    final CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
  }

  @override
  Future<UserModel> getUserFromFireStore(UserModel user) async {
    final CollectionReference<UserModel> userCollection = getUserCollection();
    final DocumentSnapshot<UserModel> documentSnapshot = await userCollection.doc(user.id).get();
    return documentSnapshot.data()!;
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      FirebaseErrorHandler.handleFirebaseAuthError(e);
    }
  }

  @override
  Future<UserModel?> register(String name, String email, String password, String phone) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.sendEmailVerification();
      final user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
      if (userCredential.additionalUserInfo!.isNewUser) await addUserToFireStore(user);
      return user;
    } on FirebaseAuthException catch (error) {
      throw FirebaseErrorHandler.handleFirebaseAuthError(error);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final CollectionReference<UserModel> userCollection = getUserCollection();
      final DocumentSnapshot<UserModel> documentSnapshot =
          await userCollection.doc(userCredential.user!.uid).get();
      if (!userCredential.user!.emailVerified) {
        throw const RemoteException('Please Verify Your Email Before Logging In');
      }
      return documentSnapshot.data()!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId: '751496645127-336f22eb73cdrjk4qsvkgbtcrr0s426l.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final authClient = googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['email', 'profile']);

      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? '',
        email: userCredential.user?.email ?? '',
        phone: userCredential.user?.phoneNumber ?? '',
      );

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await addUserToFireStore(user);
      }

      final UserModel userModel = await getUserFromFireStore(user);
      return userModel;
    } on GoogleSignInException catch (e) {
      throw RemoteException('Google Sign-In failed: ${e.code.name}');
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"],
      );

      if (loginResult.status != LoginStatus.success) {
        throw const RemoteException('Facebook login failed or cancelled.');
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      final user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? '',
        email: userCredential.user?.email ?? '',
        phone: userCredential.user?.phoneNumber ?? '',
      );

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await addUserToFireStore(user);
      }
      final UserModel userModel = await getUserFromFireStore(user);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
