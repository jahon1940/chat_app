part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class SetBottomEvent extends MainEvent {
  final BottomMenu menu;
  SetBottomEvent({required this.menu});
  @override
  List<Object?> get props => [menu];

}
class LoadEvent extends MainEvent {

  @override
  List<Object?> get props => [];
}
