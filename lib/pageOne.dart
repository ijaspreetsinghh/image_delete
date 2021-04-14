import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_delete/pageTwoDesc.dart';
import 'main.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  Future gettingData;

  Widget cardBuilder(List<DummyDatum> data) {
    void deleter(int index) {
      setState(() {
        data.removeAt(index);
      });
    }

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageTwo(
                        image: data[position].image,
                        title: data[position].title,
                        time: data[position].time,
                        date: data[position].date,
                        description: data[position].description,
                      )),
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        child: Image(
                          image: NetworkImage(
                            data[position].image,
                          ),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                          size: 28,
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => AlertDialog(
                            title: Text("Delete this item"),
                            content: Text(
                                "Are you sure you want to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleter(position);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Colors.red.withOpacity(.1)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          data[position].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data[position].date,
                            ),
                            Text(
                              data[position].time,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data[position].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    gettingData = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<DummyDatum>>(
        future: gettingData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return cardBuilder(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
