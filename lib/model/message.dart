class Message {
  final String id;
  final String title;
  final String startingMessageBody;
  final String endingMessageBody;
  final DateTime dateTime;
  final String couponCode;
  final bool copyable;

  Message({
    required this.id,
    required this.title,
    required this.startingMessageBody,
    required this.endingMessageBody,
    required this.dateTime,
    required this.couponCode,
    this.copyable = true,
  });
}
