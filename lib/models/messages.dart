class Messages {
  Messages({
    required this.msg,
    required this.toId,
    required this.fromId,
    required this.read,
    required this.sent,
    required this.type,
  });

  late final String msg;
  late final String toId;
  late final String fromId;
  late final String read;
  late final String sent;
  late final MsgType type;

  Messages.fromJson(json) {
    msg = json['msg'] ?? 'NA';
    toId = json['toId'] ?? 'NA';
    fromId = json['fromId'] ?? 'NA';
    read = json['read'];
    sent = json['sent'] ?? 'NA';
    type = json['type'].toString() == MsgType.text.name
        ? MsgType.text
        : MsgType.image;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['toId'] = toId;
    data['fromId'] = fromId;
    data['read'] = read;
    data['sent'] = sent;
    data['type'] = type.name;
    return data;
  }
}

enum MsgType { text, image }
