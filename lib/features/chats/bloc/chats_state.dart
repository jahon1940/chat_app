import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
@immutable
class ChatsState extends Equatable {
final  GoogleSignInAccount? googleUser;

  const ChatsState({this.googleUser});

 ChatsState copyWith({
  GoogleSignInAccount? googleUser,
 }) {
  return ChatsState(googleUser:googleUser??this.googleUser);
 }

 @override
 List<Object> get props => [];
}




