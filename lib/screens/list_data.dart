import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/data_model.dart';
import 'package:latihan_responsi/screens/detail_data.dart';
import 'package:latihan_responsi/services/api_helper.dart';

class ListData extends StatefulWidget {
  final String endPoint;
  final String title;
  const ListData({super.key, required this.endPoint, required this.title});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  // Future<List<DataModel>> fetchData() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<DataModel>>(
                  future: ApiHelper.fetchList(widget.endPoint),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error : ${snapshot.error}"));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailData(
                                            title: data[index].title,
                                            newsSite: data[index].newsSite,
                                            imageUrl: data[index].imageUrl,
                                            summary: data[index].summary,
                                            publishedAt:
                                                data[index].publishedAt,
                                            url: data[index].url)));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(snapshot.data![index].title),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
