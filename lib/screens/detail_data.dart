import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailData extends StatelessWidget {
  final String title;
  final String newsSite;
  final String imageUrl;
  final String summary;
  final String publishedAt;
  final String url;

  const DetailData(
      {super.key,
      required this.title,
      required this.newsSite,
      required this.imageUrl,
      required this.summary,
      required this.publishedAt,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) =>
                    Text("Gambar gagal di load"),
              ),
              SizedBox(height: 10),
              Text(newsSite, style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(summary),
              SizedBox(height: 10),
              Text(publishedAt, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text(url, style: TextStyle(color: Colors.blue)),
            ],
          ),
        ));
  }
}
