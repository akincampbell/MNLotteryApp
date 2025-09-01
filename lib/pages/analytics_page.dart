import 'package:flutter/material.dart';
import '../services/analytics_service.dart';
import '../services/notifications_service.dart';
class AnalyticsPage extends StatefulWidget { const AnalyticsPage({super.key}); @override State<AnalyticsPage> createState()=>_AnalyticsPageState(); }
class _AnalyticsPageState extends State<AnalyticsPage>{
  final _a=AnalyticsService(); final _n=NotificationsService();
  @override void initState(){ super.initState(); _n.init(); }
  @override Widget build(BuildContext c){ final ev=_a.events.reversed.toList();
    return Scaffold(appBar: AppBar(title: const Text('Analytics & Messaging (Demo)')), body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Row(children:[ FilledButton.icon(icon: const Icon(Icons.notifications_active_outlined), label: const Text('Send Reminder (Simulate FCM)'), onPressed: () async { await _n.sendDemoReminder(); if(mounted && _n.lastMockMessage!=null){ ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(_n.lastMockMessage!))); }},),
        const SizedBox(width:12), const Expanded(child: Text('Simulates HubSpot-style re-engagement push via FCM.')), ]),
      const SizedBox(height:16),
      Text('Recent Events (${ev.length})', style: Theme.of(c).textTheme.titleMedium),
      const SizedBox(height:8),
      Expanded(child: ListView.separated(itemCount: ev.length, separatorBuilder: (_, __)=>const Divider(height:1),
        itemBuilder: (_, i){ final e=ev[i]; return ListTile(title: Text(e['name']?.toString()??''), subtitle: Text(e['params']?.toString()??'{}'), trailing: Text((e['ts']??'').toString(), style: const TextStyle(fontSize:12)),); },)),
      const SizedBox(height:8),
      const Text('Connect Firebase Analytics to Looker Studio for visual dashboards.', style: TextStyle(fontSize:12)),
    ]))); }
}
