import '../config.dart';
// ignore: uri_does_not_exist
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class DemoUser { final String uid; final String? email; const DemoUser({required this.uid, this.email}); }

class AuthService {
  static final AuthService _i = AuthService._internal();
  factory AuthService() => _i;
  AuthService._internal();
  DemoUser? _cur;
  DemoUser? get currentUser => _cur;
  Future<DemoUser?> signInWithEmail(String email, String password) async {
    if (kMockMode) { _cur = DemoUser(uid: 'mock_${email.hashCode}', email: email); return _cur; }
    final cred = await fb_auth.FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    final u = cred.user!; _cur = DemoUser(uid: u.uid, email: u.email); return _cur;
  }
  Future<DemoUser> continueAsGuest() async { _cur = const DemoUser(uid:'guest'); return _cur!; }
  Future<void> signOut() async { if (!kMockMode) await fb_auth.FirebaseAuth.instance.signOut(); _cur = null; }
}
