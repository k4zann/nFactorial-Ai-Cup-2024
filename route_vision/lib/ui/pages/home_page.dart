import 'package:flutter/material.dart';
import 'package:route_vision/constants/app_strings.dart';
import 'package:route_vision/models/ready_roadmap_model.dart';
import 'package:route_vision/ui/widgets/textfield_generate_button.dart';

import 'ready_roadmap_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, TextEditingController> _controllers = {
    'search': TextEditingController(),
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey there! 👋'),
        backgroundColor: const Color(0xFF1C1B29),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithGenerateButton(
              searchController: _controllers['search']!,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: AppStrings.titles.length,
                itemBuilder: (context, index) {
                  return _buildCard(
                    AppStrings.titles[index],
                    AppStrings.subtitles[index],
                    AppStrings.colors[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadyRoadmapPage(
                            direction: ReadyRoadmapModel(
                              title: AppStrings.titles[index],
                              description: AppStrings.subtitles[index],
                              image: '',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, Color color, {Function()? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Card(
        color: const Color(0xFF2A293B),
        borderOnForeground: true,
        shadowColor: color,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: color, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
