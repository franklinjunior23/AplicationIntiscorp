import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'https://dev.intisoft.com.pe/api/v1';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> requestBody = {'usuario': username, 'contraseña': password};

    final response = await http.post(
      Uri.parse('$apiUrl/auth/login'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      // Verificar si el inicio de sesión fue exitoso
      if (data['loged'] == true) {
        // Guardar el token y los detalles del usuario en SharedPreferences
        await _saveUserData(data['token_user'], data['user']);
        return data;
      } else {
        // Manejar el caso de inicio de sesión fallido
        throw Exception('Inicio de sesión fallido');
      }
    } else {
      // Manejar otros códigos de estado si es necesario
      throw Exception('Error de inicio de sesión. Código de estado: ${response.statusCode}');
    }
  }

  Future<void> _saveUserData(String token, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(user));
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user');
    if (userData != null) {
      return jsonDecode(userData);
    } else {
      return null;
    }
  }
}
