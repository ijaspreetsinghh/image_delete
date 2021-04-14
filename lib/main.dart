import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pageOne.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageOne(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<List<DummyDatum>> getData() async {
  var result = await http
      .get(Uri.http('nexever.in', 'demo/api.php', {'dummy_info': ''}));
  final nexEver = nexEverFromJson(result.body).dummyDetails.dummyData;

  return nexEver;
}

NexEver nexEverFromJson(String str) => NexEver.fromJson(json.decode(str));

String nexEverToJson(NexEver data) => json.encode(data.toJson());

class NexEver {
  NexEver({
    this.dummyDetails,
  });

  DummyDetails dummyDetails;

  factory NexEver.fromJson(Map<String, dynamic> json) => NexEver(
        dummyDetails: DummyDetails.fromJson(json["Dummy Details"]),
      );

  Map<String, dynamic> toJson() => {
        "Dummy Details": dummyDetails.toJson(),
      };
}

class DummyDetails {
  DummyDetails({
    this.dummyData,
  });

  List<DummyDatum> dummyData;

  factory DummyDetails.fromJson(Map<String, dynamic> json) => DummyDetails(
        dummyData: List<DummyDatum>.from(
            json["Dummy data"].map((x) => DummyDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Dummy data": List<dynamic>.from(dummyData.map((x) => x.toJson())),
      };
}

class DummyDatum {
  DummyDatum({
    this.image,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  String image;
  String title;
  String description;
  String date;
  String time;

  factory DummyDatum.fromJson(Map<String, dynamic> json) => DummyDatum(
        image: json["image"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      };
}
