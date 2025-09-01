import '../config.dart';
import 'auth_service.dart';
// ignore: uri_does_not_exist
import 'package:cloud_firestore/cloud_firestore.dart' as fb_fs;

class FirestoreService {
  static final FirestoreService _i = FirestoreService._internal();
  factory FirestoreService() => _i;
  FirestoreService._internal();
  final List<Map<String,dynamic>> _mock = [];
  List<Map<String,dynamic>> get allEntries => List.unmodifiable(_mock);
  Future<void> saveTicketEntry(String code) async {
    final uid = AuthService().currentUser?.uid ?? 'unknown';
    if (kMockMode) { _mock.add({'code': code, 'userId': uid, 'timestamp': DateTime.now().toIso8601String()}); }
    else { await fb_fs.FirebaseFirestore.instance.collection('second_chance_entries').add({'code': code, 'userId': uid, 'timestamp': DateTime.now().toUtc()}); }
  }
}
