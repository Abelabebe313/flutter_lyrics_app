import 'package:flutter/material.dart';
import 'package:lyrics_app/widgets/lyrics_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SongDetailsScreen extends StatefulWidget {
  final String title;
  final String chord;
  final String author;
  final List<String> lyrics;

  const SongDetailsScreen({super.key, required this.title, required this.chord, required this.author, required this.lyrics});

  @override
  State<SongDetailsScreen> createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292C31),
      appBar: AppBar(
        backgroundColor: Color(0xFF292C31),
        foregroundColor: Color(0xFFA9DED8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title,
            style: TextStyle(
              color: Color(0xFFA9DED8),
            ),
          ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('chord: C Major',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text('written by: Dawit Getachew',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            LyricsWidget(lyrics: widget.lyrics),
          ],
        ),
      ),
    );
  }
}
