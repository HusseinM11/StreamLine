

import 'dart:convert';
// import http package
import 'package:http/http.dart' as http;

Future sendEmail(String name, String message, String email) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_k60ng6q';
  const templateId = 'template_h2m8bzs';
  const userId = 'JCqPZwWOFfdQWxFg1';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': name,
          'from_email': email,
          'message': message
        }
      }));
  return response.statusCode;
}