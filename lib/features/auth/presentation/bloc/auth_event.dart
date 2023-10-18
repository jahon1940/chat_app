part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

//Sign up and Sign in with Google
class SignUpGoogleEvent extends AuthEvent {
  SignUpGoogleEvent();

  @override
  List<Object?> get props {
    return [];
  }
}
//Sign in with Email
class SignInEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEmailEvent({required this.email, required this.password});

  @override
  List<Object?> get props {
    return [];
  }
}
//Sign up with Email
class SignUpEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final File? photo;


  SignUpEmailEvent({required this.email, required this.password, required this.name, required this.photo});

  @override
  List<Object?> get props {
    return [];
  }
}
// Load firebase instance
class LoadeEvent extends AuthEvent {

  @override
  List<Object?> get props => [];
}
class GetImageEvent extends AuthEvent {

  @override
  List<Object?> get props => [];
}
