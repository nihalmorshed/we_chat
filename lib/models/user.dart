class ChatUser {
  ChatUser({
    required this.about,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.pushToken,
  });
  late final String about;
  late final String name;
  late final String createdAt;
  late final String lastActive;
  late final String id;
  late final bool isOnline;
  late final String email;
  late final String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? 'No about';
    name = json['name'] ?? 'No name';
    createdAt = json['created_at'] ?? 'No created_at';
    lastActive = json['last_active'] ?? 'No last_active';
    id = json['id'] ?? 'No id';
    isOnline = json['is_online'] ?? false;
    email = json['email'] ?? 'No email';
    pushToken = json['push_token'] ?? 'No push_token';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}
