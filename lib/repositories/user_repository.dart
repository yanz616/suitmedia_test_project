import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suitmedia_project1/models/user.dart';

class UserRepository {
  final String baseUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?page=$page'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> usersJson = data['data'];

      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Failed Load Users");
    }
  }
}
