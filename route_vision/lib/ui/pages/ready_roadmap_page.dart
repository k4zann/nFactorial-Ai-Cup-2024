import 'package:flutter/material.dart';
import 'package:route_vision/models/ready_roadmap_model.dart';

class ReadyRoadmapPage extends StatelessWidget {
  const ReadyRoadmapPage({super.key, required this.direction});
  final ReadyRoadmapModel direction;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ready Roadmap Page'),
        backgroundColor: const Color(0xFF1C1B29),
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your roadmap is ready! 🚀', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Check your email for the roadmap', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}