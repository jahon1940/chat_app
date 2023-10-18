part of 'user_bloc.dart';


class UserState extends Equatable {
  final File? file;
  const UserState({
   this.file

  });
  UserState copyWith({
    File? file,

  }) =>
      UserState(
          file: file ?? this.file
      );
  @override
  List<Object> get props => [];
}

