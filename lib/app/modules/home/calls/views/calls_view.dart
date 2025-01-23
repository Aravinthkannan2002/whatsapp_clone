import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calls_controller.dart';

class CallsView extends GetView<CallsController> {
  const CallsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the list
    final callLogs = [
      {"name": "John Doe", "time": "Today :4.00 PM"},
      {"name": "Jane Smith", "time": "Yesterday :3.00 PM"},
      {"name": "Alice Brown", "time": "Today :5.30 PM"},
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: callLogs.length,
              itemBuilder: (context, index) {
                final call = callLogs[index];
                return Column(
                  children: [
                    newMethod(call, Icons.call),
                    // if (index < callLogs.length - -1) const Divider(), // Divider between items
                     newMethod(call, Icons.video_call),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile newMethod(Map<String, String> call, IconData icon) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        call["name"]!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 2),
          Text(
            call["time"]!,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
