class NotificationBody {
  String? title;
  String? body;
  String? id;
  String? type;
  String? typeData;
  String? key;

  NotificationBody({
    required this.title,
    required this.body,
    required this.id,
    required this.type,
    required this.typeData,
    this.key,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'id': id,
      'type': type,
      'type_data': typeData,
      'key': key,
    };
  }

  factory NotificationBody.fromMap(Map<String, dynamic> map) =>
      NotificationBody(
        title: map['title'],
        body: map['body'],
        id: map['id'],
        type: map['type'],
        typeData: map['type_data'],
        key: map['key'],
      );
}