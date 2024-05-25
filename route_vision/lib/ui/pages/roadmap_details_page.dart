import 'package:flutter/material.dart';

class RoadmapDetailsPage extends StatefulWidget {
  const RoadmapDetailsPage({Key? key}) : super(key: key);

  @override
  _RoadmapDetailsPageState createState() => _RoadmapDetailsPageState();
}

class _RoadmapDetailsPageState extends State<RoadmapDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roadmap Details Page'),
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