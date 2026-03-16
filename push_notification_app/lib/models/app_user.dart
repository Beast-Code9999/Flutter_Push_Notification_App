class AppUser {
  String id;
  String email;
  String role;

  AppUser({
    required this.id,
    required this.email,
    required this.role,
  });

  // Convert object to Firestore map (Save)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }

  // Convert Firestore map to object (Fetch)
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
    );
  }
}