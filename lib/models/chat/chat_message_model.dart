/// Single chat message for UI display.
class ChatMessageModel {
  const ChatMessageModel({
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;
}
