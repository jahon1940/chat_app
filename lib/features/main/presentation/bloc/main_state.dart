part of 'main_bloc.dart';

class MainState extends Equatable {
  final BottomMenu bottomMenu;
  final FirebaseAuth? firebaseAuth;
  final DatabaseReference? dbRef;

  const MainState({
    this.bottomMenu = BottomMenu.chats,
    this.firebaseAuth,
    this.dbRef,
  });

  MainState copyWith({
    BottomMenu? bottomMenu,
    FirebaseAuth? firebaseAuth,
    DatabaseReference? dbRef,
  }) {
    return MainState(
      bottomMenu: bottomMenu ?? this.bottomMenu,
      firebaseAuth: firebaseAuth ?? this.firebaseAuth,
      dbRef: dbRef ?? this.dbRef,
    );
  }

  @override
  List<Object> get props => [bottomMenu];
}

enum BottomMenu { chats, settings }
