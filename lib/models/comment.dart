class Com {
  final dynamic postId;
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic body;

  Com({this.postId, this.id, this.name, this.email, this.body});

  factory Com.fromJson(Map<String, dynamic> json) {
    return Com(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
