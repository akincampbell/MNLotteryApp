import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/analytics_service.dart';
class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final _email=TextEditingController(), _pass=TextEditingController(); bool _busy=false;
  Future<void> _signIn() async { setState(()=>_busy=true);
    try { await AuthService().signInWithEmail(_email.text.trim(), _pass.text.trim());
      await AnalyticsService().logEvent('login_success', params:{'method':'email'});
      if(mounted) Navigator.pushReplacementNamed(context,'/home');
    } catch(e){ if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-in failed: $e'))); }
    finally { setState(()=>_busy=false);}}
  Future<void> _guest() async { await AuthService().continueAsGuest(); await AnalyticsService().logEvent('login_success', params:{'method':'guest'});
    if(mounted) Navigator.pushReplacementNamed(context,'/home'); }
  @override Widget build(BuildContext context){ return Scaffold(body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth:420),
    child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/logo.png', width:120), const SizedBox(height:16),
      Text('MN Lottery Demo', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height:24),
      TextField(controller:_email, decoration: const InputDecoration(labelText:'Email')),
      const SizedBox(height:12),
      TextField(controller:_pass, decoration: const InputDecoration(labelText:'Password'), obscureText:true),
      const SizedBox(height:24),
      FilledButton(onPressed:_busy?null:_signIn, child:_busy?const CircularProgressIndicator():const Text('Sign in')),
      const SizedBox(height:8),
      TextButton(onPressed:_busy?null:_guest, child: const Text('Continue as Guest')),
      const SizedBox(height:16),
      const Text('Prototype & Demo Only — Not an official MN Lottery app.', textAlign: TextAlign.center),
    ]))))); }
}
