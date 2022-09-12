class Post {
  final dynamic userId;
  final dynamic id;
  final dynamic title;
  final dynamic body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
