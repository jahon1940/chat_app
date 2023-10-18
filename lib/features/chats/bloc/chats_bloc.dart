import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'chats_event.dart';
import 'chats_state.dart';


class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super( const ChatsState()) {
    on<ChatsEvent>(_googleSignIn);
  }
  Future <String?> _googleSignIn(ChatsEvent event, Emitter<ChatsState> emit) async{
    final googleSign = GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

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

      if (kDebugMode) {
        print(userCredential.user);
      }
      if (kDebugMode) {
        print(googleUser.photoUrl);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return '';
    } catch (e, s) {
      debugPrint('$e, $s');
      return '';
    }

  }}



