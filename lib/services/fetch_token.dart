import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendTokenToAPI(String userId, String fcmToken) async {
  final response = await http.post(
    Uri.parse('https://trading.rscapitalgrowth.in/device_token_insert.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_id': userId,
      'fcm_token': fcmToken,
    }),
  );

  if (response.statusCode == 200) {
    print('Token sent successfully');
  } else {
    throw Exception('Failed to send token');
  }
}
