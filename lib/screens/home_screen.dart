import 'dart:developer';

import 'package:flutter/material.dart';
import 'song_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}): super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late final DatabaseReference _databaseReference;
  List<Map<dynamic, dynamic>> songsData = [];


  @override
  void initState() {

    super.initState();
    fetchData();
  }

void fetchData(){
  _databaseReference = FirebaseDatabase.instance.ref().child('lyrics');

  _databaseReference.onValue.listen((event) {
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      dynamic value = snapshot.value;

      try {
        if (value is List<dynamic>) {
          print("Checking value is a List<dynamic>");

          List<Map<dynamic, dynamic>> newData = [];

          for (var item in value) {
            if (item is Map<dynamic, dynamic>) {
              print('Processing item: $item');
              Map<String, dynamic> songData = {
                'id': item['id'],
                'title': item['title'],
                'author': item['author'],
                'chord': item['chord'],
                'lyrics': List<String>.from(item['lyrics']),
              };
              newData.add(songData);
            }
          }

          setState(() {
            songsData = newData;
          });
        } else {
          print("Value is not in the expected List<dynamic> format.");
          print(value.toString());
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
      fetchData();
    },
    child:Scaffold(
      backgroundColor: Color(0xFF292C31),
      appBar: AppBar(
        backgroundColor: Color(0xFF292C31),
        title: const Center(
          child: Text(
            'Lyrics App',
            style: TextStyle(
              color: Color(0xFFA9DED8),
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            // search bar
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search a lyrics ...",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins-ExtraLight',
                      color: Colors.grey.shade400,
                      fontSize: 15,
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 10, top: 12, bottom: 12), // Add padding here
                    border: InputBorder.none,
                    suffixIcon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA9DED8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        ),
                        color: Color(0xFF292C31),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: const Color(0xFF292C31),
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                  itemCount: songsData.length,
                  itemBuilder: (context, index) {
                    final song = songsData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SongDetailsScreen(
                            title: song['title'],
                            chord: song['chord'],
                            author: song['author'],
                            lyrics: song['lyrics'],
                          )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: Color(0xFFA9DED8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(190, 196, 202, 0.2),
                                blurRadius: 14,
                                offset: Offset(0, 9),
                              ),
                            ],
                          ),
                          child: Card(
                            color: Color(0xFFA9DED8),
                            margin: const EdgeInsets.all(0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ListTile(
                              title: Text(song['title'],  // Title Goes here
                                style: TextStyle(
                                  fontFamily: 'Poppins-ExtraLight',
                                  fontSize: 17,
                                  color: Color(0xFF292C31),
                                ),
                              ),
                              subtitle: Text(song['author'],  // Author Goes here
                                style: TextStyle(
                                  fontFamily: 'Poppins-ExtraLight',
                                  fontSize: 14,
                                  color: Color(0xFF292C31),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  size: 26,
                                ),
                                color: Color(0xFF292C31),
                                onPressed: () {},
                              ),
                            )
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
