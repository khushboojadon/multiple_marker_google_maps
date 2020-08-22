import 'package:flutter/material.dart';
import 'package:multiple_marker_google_maps/service/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Api _api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('People Details')),
      body: Container(
          child: FutureBuilder(
              future: _api.getdetails(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data.success.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            margin: EdgeInsets.all(10.0),
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                      child: CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage: NetworkImage(
                                        "${snapshot.data.success[index].image}"),
                                    backgroundColor: Colors.blue,
                                  )),
                                  SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data.success[index].name ??
                                            "NO name",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(snapshot
                                              .data.success[index].address ??
                                          "No address"),
                                      SizedBox(height: 5.0),
                                      Text(snapshot
                                              .data.success[index].contact ??
                                          "No contact")
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          );
                        });
              })),
    );
  }
}
