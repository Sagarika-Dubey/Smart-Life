import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchFCMTokens() async {
  final response = await http.get(
      Uri.parse('https://trading.rscapitalgrowth.in/device_token_list.php'));

  if (response.statusCode == 201) {
    List<dynamic> tokens = jsonDecode(response.body);
    return tokens.map((token) => token.toString()).toList();
  } else {
    throw Exception('Failed to load FCM tokens');
  }
}
