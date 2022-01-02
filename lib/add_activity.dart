import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  addActivityToFireBase() async {
    FirebaseFirestore.instance.collection('activities').add({
      "activity_description": "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine.",
      "activity_id": "3",
      "activity_image": "https://i.pinimg.com/originals/dc/87/67/dc876709b8d32bb0b388af21dce7e755.jpg",
      "activity_name_ar": "زواج فلسطيني تقليدي",
      "activity_name_en": "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine",
      "activity_video" : "https://www.youtube.com/watch?v=QzZWmBRzJbk&ab_channel=Gazadeserveslife",
      "activity_type": {
        "activity_type_id": "2",
      },
      "city": {
        "city_id": "2",
      },
      "country": {
        "country_id": "3",
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: FlutterLogo(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addActivityToFireBase,
      ),
    );
  }
}
