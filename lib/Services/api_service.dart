import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://najmul-hasan-shihab.github.io/event_json_api/event.json';

  Future<List<dynamic>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/events')); // Adjust endpoint
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Convert response to a list
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
