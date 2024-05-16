import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> postData(
    {required String link, required Map<String, dynamic> data}) async {
  try {
    final response = await http.post(
      Uri.parse(link),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      print('Data posted successfully');
    } else {
      print('Failed to post data: ${response.statusCode}');
    }
    return json.decode(response.body);
  } catch (e) {
    print('Error posting data: $e');
    throw e;
  }
}
