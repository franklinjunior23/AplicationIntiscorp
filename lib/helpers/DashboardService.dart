// empresa_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmpresaService {
  final String apiUrl = 'https://dev.intisoft.com.pe/api/v1';

  Future<List<Empresa>> obtenerEmpresas() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/empresas'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Empresa.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener empresas. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener empresas: $e');
    }
  }
}

class Empresa {
  final int id;
  final String nombre;
  final String lugar;
  final List<Sucursal> sucursales;

  Empresa({
    required this.id,
    required this.nombre,
    required this.lugar,
    required this.sucursales,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['id'],
      nombre: json['nombre'],
      lugar: json['lugar'],
      sucursales: (json['Sucursales'] as List<dynamic>? ?? [])
          .map<Sucursal>((sucursal) => Sucursal.fromJson(sucursal))
          .toList(),
    );
  }
}

class Sucursal {
  final int id;
  final String nombre;

  Sucursal({
    required this.id,
    required this.nombre,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}