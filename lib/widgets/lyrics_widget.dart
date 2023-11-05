import 'package:flutter/material.dart';

class LyricsWidget extends StatelessWidget {
  final List<String> lyrics;

  LyricsWidget({required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15.0), // Add spacing
          // Create a ListView or other suitable widget to display the lyrics
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: lyrics.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  lyrics[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
