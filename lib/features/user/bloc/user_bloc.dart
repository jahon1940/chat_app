import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<GetImageEvent>(_getImage);
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
