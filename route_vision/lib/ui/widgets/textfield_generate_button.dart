import 'package:flutter/material.dart';

class TextFieldWithGenerateButton extends StatefulWidget {
  const TextFieldWithGenerateButton({super.key,
    required this.searchController,
    required this.onGenerate
  });

  final TextEditingController searchController;
  final Function() onGenerate;
  @override
  State<TextFieldWithGenerateButton> createState() => _TextFieldWithGenerateButtonState();
}

class _TextFieldWithGenerateButtonState extends State<TextFieldWithGenerateButton> {


  @override
  void dispose() {
    widget.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Generate a roadmap for your career! 🚀',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.searchController,
                onTap: () {
                  widget.searchController.selection = TextSelection(baseOffset: 0, extentOffset: widget.searchController.text.length);
                },
                decoration: InputDecoration(
                  hintText: 'Enter your career path',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                widget.onGenerate();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A293B),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white),
                  SizedBox(width: 5),
                  Text('Generate', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
