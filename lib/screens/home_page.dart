import 'package:flutter/material.dart';
import 'package:latihan_responsi/screens/list_data.dart';
import 'package:latihan_responsi/screens/login_page.dart';
import 'package:latihan_responsi/services/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Selamat datang " + "afif"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  print("News");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListData(
                                endPoint: '/articles',
                                title: "Berita Hari Ini",
                              )));
                },
                child: Card(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.article, size: 50, color: Colors.blue),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('News',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Dapatkan berita paling terbaru")
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  print("Blog");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListData(
                                endPoint: '/blogs',
                                title: "Blog Hari Ini",
                              )));
                },
                child: Card(
                  color: Colors.green[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.book, size: 50, color: Colors.green),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Blogs',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Dapatkan blog paling terbaru")
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  print("Report");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListData(
                                endPoint: '/reports',
                                title: "Report Hari Ini",
                              )));
                },
                child: Card(
                  color: Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.report, size: 50, color: Colors.red),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reports',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Dapatkan report paling terbaru")
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  showLogoutDialog(context);
                },
                child: Card(
                  color: Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 50, color: Colors.red),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Logout',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            // Text("Dapatkan report paling terbaru")
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal')),
            ElevatedButton(
                onPressed: () {
                  DatabaseHelper.instance.logout;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: Text('Logout'))
          ],
        );
      });
}
