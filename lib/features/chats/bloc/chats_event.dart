import 'package:equatable/equatable.dart';

import 'chats_state.dart';

abstract class ChatsEvent extends Equatable {

  const ChatsEvent();
  @override
  List<Object?> get props {
    return [];
  }
}
