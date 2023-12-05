import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/helpers/Auth.dart';
import 'package:project/helpers/DashboardService.dart';

void main() {
  runApp(NavigationBarApp());
}

class NavigationBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}


class DashboardPage extends StatelessWidget {
  final EmpresaService empresaService = EmpresaService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService().getUserData(),
      
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se obtienen los datos
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si hay algún problema
          return Text('Error al obtener los datos del usuario');
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Maneja el caso en el que no hay datos disponibles
          return Text('No hay información de usuario');
        }

        // Ahora puedes acceder a los datos del usuario desde snapshot.data
        Map<String, dynamic> userData = snapshot.data!;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEEE, d MMMM y').format(now);

        return Scaffold(
          backgroundColor: Color(0xFF292929),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                // Columna 1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido, ${userData['nombre']}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6090FF),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Columna 2
                ElevatedButton(
                  onPressed: () {
                    // Lógica para crear empresa
                    _mostrarModalCrearEmpresa(context);
                  },
                  child: Text('Crear Empresa'),
                ),

                SizedBox(height: 10),

                // Columna 3
                Slider(
                  // Configuración del slider
                  onChanged: (double value) {
                    // Lógica cuando se cambia el valor del slider
                  },
                  value: 0.0, // Ajusta el valor inicial según tus necesidades
                  min: 0.0, // Ajusta el valor mínimo según tus necesidades
                  max: 10.0, // Ajusta el valor máximo según tus necesidades
                ),

                SizedBox(height: 20),

                // Columna 4
                ElevatedButton(
                  onPressed: () {
                    // Lógica para dirigir a la página de detalles del slider
                    // Puedes usar Navigator para navegar a una nueva página
                    Navigator.pushNamed(context, '/detalle_slider');
                  },
                  child: Text('Ver Detalles del Slider'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar lógica para cerrar sesión
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            
            backgroundColor: Colors.black,
            selectedItemColor: const Color.fromARGB(255, 238, 190, 190),
            unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                label: 'Empresas',
              ),
             
              BottomNavigationBarItem(icon: Icon(Icons.logout_rounded), label: 'Salir')
              
            ],
          ),
        );
      },
    );
  }
}

void _mostrarModalCrearEmpresa(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Crear Empresa'),
        content: CrearEmpresaForm(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Cerrar el modal al presionar Cancelar
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para realizar la petición al backend
              // Puedes llamar a una función aquí para realizar la petición
              // y cerrar el modal cuando sea necesario
              // Ejemplo: _realizarPeticionBackend();
              Navigator.of(context)
                  .pop(); // Cerrar el modal después de confirmar
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}

class CrearEmpresaForm extends StatefulWidget {
  @override
  _CrearEmpresaFormState createState() => _CrearEmpresaFormState();
}

class _CrearEmpresaFormState extends State<CrearEmpresaForm> {
  TextEditingController _empresaController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _empresaController,
          decoration: InputDecoration(labelText: 'Empresa'),
        ),
        TextField(
          controller: _nombreController,
          decoration: InputDecoration(labelText: 'Nombre'),
        ),
      ],
    );
  }
}
