import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  String id;
  String title;
  String content;
  String sentBy;
  DateTime createdAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.sentBy,
    required this.createdAt,
    required this.isRead
  });

    // Convert object to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'sentBy': sentBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'isRead': isRead,
    };
  }

  // Convert Firestore map to object
  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      sentBy: map['sentBy'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isRead: map['isRead'] ?? false,
    );
  }
}
