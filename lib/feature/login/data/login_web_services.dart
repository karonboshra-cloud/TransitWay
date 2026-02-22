import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginWebServices {
  final String baseUrl = "http://transit-way.runasp.net";

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Login Status: ${response.statusCode}");
      print("Login Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // تعديل هنا: أي رد غير ناجح من السيرفر هنرجعه بالجملة دي
        throw "Invalid email or password";
      }
    } catch (e) {
      // لو الخطأ هو الجملة اللي إحنا حددناها فوق، بنرفعها زي ما هي
      if (e.toString() == "Invalid email or password") {
        rethrow;
      }
      // لو خطأ في الشبكة أو السيرفر واقع مثلاً
      throw "Check your internet connection and try again";
    }
  }
}