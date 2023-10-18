
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<SetBottomEvent>((SetBottomEvent event,Emitter<MainState> emit) {
      emit(state.copyWith(bottomMenu: event.menu));
    });
    on<LoadEvent>(_load);
  }
  _load(LoadEvent event, emit) {

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DatabaseReference dbRefEmailUsers = FirebaseDatabase.instance.ref().child('emailUsers');
    emit(state.copyWith(
      firebaseAuth: firebaseAuth,
      dbRef: dbRefEmailUsers,
    ));
  }
}
