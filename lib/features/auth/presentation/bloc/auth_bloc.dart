import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<SignInEmailEvent>(_signWithEmail);
    on<SignUpEmailEvent>(_signUpWithEmail);
    on<SignUpGoogleEvent>(_signUpWithGoogle);
    on<LoadeEvent>(_load);
    on<GetImageEvent>(_getImage);
  }
  Future<void> _signWithEmail(
      SignInEmailEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(firebaseStatus: Status.loading));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(state.copyWith(firebaseStatus: Status.success));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('error----${e.code}');
      }
      emit(state.copyWith(firebaseStatus: Status.error));
    }
  }

  Future<void> _signUpWithEmail(
      SignUpEmailEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(firebaseStatus: Status.loading));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      emit(state.copyWith(firebaseStatus: Status.success));

      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('emailUsers').doc(userCredential.user!.uid).set({
        'uid': userCredential.user?.uid,
        'email': event.email,
        'name': event.name,
        'photo': event.photo
      });

      final DatabaseReference dbref =
          FirebaseDatabase.instance.ref().child('emailUsers');
      dbref.push().set({
        'uid': userCredential.user!.uid,
        'email': event.email,
        'name': event.name,
        'photo': event.photo
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('error----${e.code}');
      }
      emit(state.copyWith(firebaseStatus: Status.error));
    }
  }

  Future<void> _signUpWithGoogle(
      SignUpGoogleEvent event, Emitter<AuthState> emit) async {
    final googleSign = GoogleSignIn(scopes: ['email']);

    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('emailUsers').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
        'photo': userCredential.user?.photoURL
      });

      final DatabaseReference dbref =
          FirebaseDatabase.instance.ref().child('emailUsers');
      dbref.push().set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
        'photo': userCredential.user?.photoURL
      });

      if (kDebugMode) {
        print(userCredential.user);
      }
      if (kDebugMode) {
        print(dbref);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return;
    } catch (e, s) {
      debugPrint('$e, $s');
      return;
    }
  }

  _load(LoadeEvent event, emit) {
    User user = FirebaseAuth.instance.currentUser!;
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Users');

    emit(state.copyWith(
      user: user,
      dbRef: dbRef,
    ));
  }

  _getImage(GetImageEvent event, emit) async {
    File? file;
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    file = File(img!.path);

    emit(state.copyWith(file: file));
  }
}
