import 'package:cloud_firestore/cloud_firestore.dart';

class Command {
  String id;
  Map<String, dynamic> medicine;
  int quantity;
  String uid;
  Timestamp timestamp;
  String status;

  Command({
    required this.id,
    required this.medicine,
    required this.quantity,
    required this.uid,
    required this.timestamp,
    this.status = 'encours',
  });

  factory Command.fromMap(Map<String, dynamic> map) {
    return Command(
      id: map['id'] ?? '',
      medicine: Map<String, dynamic>.from(map['medicine'] ?? {}),
      quantity: map['quantity'] ?? 0,
      uid: map['uid'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      status: map['status'] ?? 'encours',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicine': medicine,
      'quantity': quantity,
      'uid': uid,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
