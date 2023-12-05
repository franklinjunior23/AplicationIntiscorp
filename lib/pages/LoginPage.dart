import 'package:flutter/material.dart';
import 'package:project/helpers/Auth.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292929), // Fondo negro personalizado
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'INTISCORP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.center,
              child: Image.network(
                'https://www.intiscorp.com.pe/wp-content/uploads/2022/10/1-1-1.png',
                width: 170.0,
                height: 160.0,
                 fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  filled: true,
                  fillColor: Color.fromARGB(
                      164, 158, 158, 158), // Color personalizado #919191
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordes redondos
                    borderSide:
                        BorderSide.none, // Sin bordes alrededor del TextField
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  labelStyle: TextStyle(
                      color: Colors.white, fontSize: 15.0) // Espaciado interno
                  ),

              style: TextStyle(color: Colors.white), // Color del texto
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Color.fromARGB(
                      164, 158, 158, 158), // Color personalizado #919191
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordes redondos
                    borderSide:
                        BorderSide.none, // Sin bordes alrededor del TextField
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  labelStyle: TextStyle(
                      color: Colors.white, fontSize: 15.0) // Espaciado interno
                  ),

              style: TextStyle(color: Colors.white), // Color del texto
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final username = usernameController.text;
                final password = passwordController.text;

                try {
                  // usar la funcion para consultar la data de la API
                  final result = await authService.login(username, password);
                  // Realizar la validación según la respuesta de la API
                  if (result['loged'] == true) {
                    // Guardar el token y navegar al dashboard
                    await Navigator.pushReplacementNamed(context, '/dashboard');
                  } else {
                    // Mostrar un mensaje de error, por ejemplo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Inicio de sesión fallido'),
                      ),
                    );
                  }
                } catch (e) {
                  // Mostrar un mensaje de error, por ejemplo
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error de inicio de sesión'),
                    ),
                  );
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
