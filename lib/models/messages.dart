class Messages {
  Messages({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.sent,
    required this.fromId,
  });
  late final String toId;
  late final String msg;
  late final String read;
  late final Type type;
  late final String sent;
  late final String fromId;

  Messages.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    sent = json['sent'].toString();
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toId'] = toId;
    _data['msg'] = msg;
    _data['read'] = read;
    _data['type'] = type;
    _data['sent'] = sent;
    _data['fromId'] = fromId;
    return _data;
  }
}

enum Type { text, image }
