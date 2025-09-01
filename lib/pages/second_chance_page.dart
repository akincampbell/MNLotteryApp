import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../services/analytics_service.dart';
class SecondChancePage extends StatefulWidget { const SecondChancePage({super.key}); @override State<SecondChancePage> createState()=>_SecondChancePageState(); }
class _SecondChancePageState extends State<SecondChancePage> {
  final _code=TextEditingController();
  Future<void> _submit() async {
    final code=_code.text.trim(); if(code.isEmpty){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a code.'))); return; }
    await FirestoreService().saveTicketEntry(code); await AnalyticsService().logEvent('ticket_entered', params:{'length':code.length});
    if(mounted){ showDialog(context: context, builder: (_)=> AlertDialog(title: const Text('Entry Successful'), content: const Text('Your second-chance entry was received!'), actions:[TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))],)); _code.clear();}
  }
  @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text('Second-Chance Contest')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      const Text('Enter Ticket Code:'), const SizedBox(height:8),
      TextField(controller:_code, decoration: const InputDecoration(border: OutlineInputBorder())),
      const SizedBox(height:12),
      FilledButton(onPressed:_submit, child: const Text('Submit Entry')),
      const SizedBox(height:16),
      const Text('Note: Demo storage only. In production, validate & secure entries.', style: TextStyle(fontSize:12)),
    ]))); }
}
