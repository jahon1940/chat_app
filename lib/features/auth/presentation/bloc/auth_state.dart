part of 'auth_bloc.dart';

 class AuthState extends Equatable {
  final Status firebaseStatus;
  final User? user;
  final DatabaseReference? dbRef;
  final File? file;
const AuthState({
  this.firebaseStatus = Status.initial,
  this.user,
  this.dbRef,this.file

});
  AuthState copyWith({
  Status? firebaseStatus,User? user,
    DatabaseReference? dbRef,
    File? file,

}) =>
      AuthState(
      firebaseStatus: firebaseStatus ?? this.firebaseStatus, user: user ?? this.user,
        dbRef: dbRef ?? this.dbRef,file: file ?? this.file
    );
@override
List<Object> get props => [];
}
enum Status { initial, loading, success, error }

extension FirebaseStatusX on Status {
  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.success;

  bool get isError => this == Status.error;
}