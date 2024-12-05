import 'dart:convert';

import 'package:latihan_responsi/models/data_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  static Future<List<DataModel>> fetchList(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        List<dynamic> data = body['results'];
        return data.map((dynamic item) => DataModel.fromMap(item)).toList();
      } else {
        throw Exception('Gagal meng fetch $endpoint');
      }
    } catch (e) {
      throw Exception('Error fetching: $e');
    }
  }
}
