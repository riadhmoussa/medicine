import 'package:cloud_firestore/cloud_firestore.dart';

class Command {
  String id;
  List<Map<String, dynamic>> medicines;
  String uid;
  Timestamp timestamp;
  String status;

  Command({
    required this.id,
    required this.medicines,
    required this.uid,
    required this.timestamp,
    this.status = 'encours',
  });

  factory Command.fromMap(Map<String, dynamic> map) {
    return Command(
      id: map['id'] ?? '',
      medicines: List<Map<String, dynamic>>.from(map['items'] ?? []),
      uid: map['uid'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      status: map['status'] ?? 'encours',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': medicines,
      'uid': uid,
      'timestamp': timestamp,
      'status': status,
    };
  }
}

