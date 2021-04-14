import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_delete/pageOne.dart';
import 'main.dart';

class PageTwo extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String date;
  final String time;
  PageTwo(
      {@required this.time,
      @required this.image,
      @required this.date,
      @required this.title,
      @required this.description});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: InteractiveViewer(
                  boundaryMargin: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  minScale: 0.5,
                  maxScale: 5,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            child: Container(
              child: Image(image: NetworkImage(image)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => AlertDialog(
                  title: Text("Delete this item"),
                  content: Text("Are you sure you want to delete this item?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No')),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => PageOne()),
                            (route) => false);
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(.1)),
                    )
                  ],
                ),
              ),
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30)),
            ),
          )
        ],
      ),
    );
  }
}
