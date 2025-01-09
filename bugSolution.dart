```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      print('Error: Data not found (404)');
      return null; // Or throw a custom exception
    } else if (response.statusCode == 500) {
      print('Error: Server error (500)');
      return null; // Or throw a custom exception
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    print('Error: Network error: $e');
    return null; // Or throw a custom exception for network issues
  } on FormatException catch (e) {
    print('Error: Invalid JSON format: $e');
    return null; // Or throw a custom exception
  } catch (e) {
    print('Error: An unexpected error occurred: $e');
    rethrow;
  }
}
```