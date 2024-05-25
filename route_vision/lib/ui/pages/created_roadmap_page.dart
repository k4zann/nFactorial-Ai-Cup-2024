import 'package:flutter/material.dart';
import 'package:route_vision/models/roadmap_details.dart';
import 'package:route_vision/services/gemini_api.dart';

class CreatedRoadmapPage extends StatefulWidget {
  const CreatedRoadmapPage({super.key, required this.roadmapDetails, required this.weekNumber});
  final RoadmapDetails roadmapDetails;
  final int weekNumber;

  @override
  _CreatedRoadmapPageState createState() => _CreatedRoadmapPageState();
}

class _CreatedRoadmapPageState extends State<CreatedRoadmapPage> {
  late GeminiApiService _geminiApiService;
  List<Map<String, dynamic>> roadmap = [];
  late Future<void> _roadmapFuture;
  late int currentWeekNumber;
  String api_key = '';

  @override
  void initState() {
    super.initState();
    currentWeekNumber = widget.weekNumber;
    _roadmapFuture = _initialize();
  }

  Future<void> _initialize() async {
    try {
      // await dotenv.load(fileName: '.env');
      // api_key = dotenv.env['API_KEY'] ?? '';
      _geminiApiService = GeminiApiService(api_key);
      await _generateRoadmap(currentWeekNumber);
    } catch (e) {
      print(e);
      throw Exception('Initialization failed: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _generateRoadmap(int weekNumber) async {
    try {
      String result = await _geminiApiService.generateCustomRoadmap(
        direction: widget.roadmapDetails.direction,
        hoursPerDay: widget.roadmapDetails.hoursPerDay,
        months: widget.roadmapDetails.months,
        learningMethod: widget.roadmapDetails.learningMethod,
        weekNumber: weekNumber,
      );
      parseRoadmap(result);
    } catch (e) {
      print(e);
      throw Exception('Failed to generate content');
    }
  }

  void parseRoadmap(String prompt) {
    final List<String> lines = prompt.split('\n');
    Map<String, dynamic>? currentWeek;
    Map<String, dynamic>? currentDay;
    List<Map<String, dynamic>> newRoadmap = [];
    for (final line in lines) {
      if (line.startsWith('##')) {
        if (currentWeek != null) {
          newRoadmap.add(currentWeek);
        }
        currentWeek = {
          'title': line.replaceAll('## ', ''),
          'days': [],
        };
      } else if (line.startsWith('**')) {
        if (currentDay != null) {
          currentWeek?['days']?.add(currentDay);
        }
        currentDay = {
          'title': line.replaceAll('**', '').trim(),
          'tasks': [],
        };
      } else if (line.startsWith('* ')) {
        currentDay?['tasks']?.add(line.replaceAll('* ', '').trim());
      }
    }
    if (currentDay != null) {
      currentWeek?['days']?.add(currentDay);
    }
    if (currentWeek != null) {
      newRoadmap.add(currentWeek);
    }
    setState(() {
      roadmap = newRoadmap;
    });
  }

  void _prevWeek() {
    if (currentWeekNumber > 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreatedRoadmapPage(
            roadmapDetails: widget.roadmapDetails,
            weekNumber: currentWeekNumber - 1,
          ),
        ),
      );
    }
  }

  void _nextWeek() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CreatedRoadmapPage(
          roadmapDetails: widget.roadmapDetails,
          weekNumber: currentWeekNumber + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.roadmapDetails.direction} Roadmap 🚀'),
        backgroundColor: const Color(0xFF1C1B29),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: _roadmapFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (roadmap.isEmpty) {
              return const Center(child: Text('No roadmap content available'));
            } else {
              final week = roadmap[0];
              final weekTitle = week['title'];
              final days = week['days'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekTitle,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final day = days[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  day['title'],
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                ...day['tasks'].map<Widget>((task) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle_outline,
                                            size: 16, color: Colors.blue),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            task,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: currentWeekNumber > 1 ? _prevWeek : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C1B29),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_left, color: Colors.white),
                              SizedBox(width: 5),
                              Text('Previous Week', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _nextWeek,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C1B29),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text('Next Week', style: TextStyle(color: Colors.white)),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
