import 'message.dart';
import 'user_model.dart';

class Conversation {
  final UserModel user;
  Message? message;

  Conversation({required this.user});
}
