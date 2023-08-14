import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FrmInfoPasantia extends StatefulWidget {
  final Map<String, dynamic> pasantia;

  FrmInfoPasantia({required this.pasantia});

  @override
  _FrmInfoPasantiaState createState() => _FrmInfoPasantiaState();
}

class _FrmInfoPasantiaState extends State<FrmInfoPasantia> {
  Map<String, dynamic> pasantiaInfo = {};
  List<ProfileInfoItem> _items = [];

  Future<void> getPasantias() async {
    var urlCasa =
        'http://192.168.100.240:7001/estudiantes/feed/${widget.pasantia['id_pasantia']}/${widget.pasantia['empresa']}';
    final response = await http.get(Uri.parse(urlCasa));
    if (response.statusCode == 200) {
      setState(() {
        pasantiaInfo = Map<String, dynamic>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void _initializeItems() {
    _items = [
      ProfileInfoItem("Modalidad", '${widget.pasantia['modalidad']}'),
      ProfileInfoItem(
          "Sueldo",
          pasantiaInfo['remunerado'] ??
              '${widget.pasantia['remunerado']}'), // Cambia pasantiaInfo['sueldo'] por el campo correcto
      ProfileInfoItem(
          "Semana",
          pasantiaInfo['horas_requeridas'] ??
              '${widget.pasantia['horas_requeridas']}'), // Cambia pasantiaInfo['horario'] por el campo correcto
    ];
  }

  @override
  void initState() {
    super.initState();
    getPasantias();
    _initializeItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: AssetImage(
              'assets/images/${widget.pasantia['imagen']}.webp',
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 0),
                          Container(
                            alignment: Alignment.center,
                            child: const CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(
                                'assets/images/startApp.jpg',
                              ), // Cambia la imagen de perfil
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.pasantia['empresa']}',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.extended(
                                onPressed: () {},
                                elevation: 0,
                                heroTag: 'mail',
                                label: const Text("Mail"),
                                icon: const Icon(Icons.mail),
                              ),
                              const SizedBox(width: 16.0),
                              FloatingActionButton.extended(
                                onPressed: () {},
                                elevation: 0,
                                heroTag: 'mesage',
                                backgroundColor: Colors.green,
                                label: const Text("WhatsApp"),
                                icon: const Icon(Icons.wechat_sharp),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 80,
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _items
                                  .map((item) => Expanded(
                                          child: Row(
                                        children: [
                                          if (_items.indexOf(item) != 0)
                                            const VerticalDivider(),
                                          Expanded(
                                              child:
                                                  _singleItem(context, item)),
                                        ],
                                      )))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Información:',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${pasantiaInfo['detalle']}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.work,
                                  color: Colors.blueGrey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Cargo: ${pasantiaInfo['imagen']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.schedule,
                                  color: Colors.blueGrey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Horario: ${pasantiaInfo['horas_requeridas']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Contactanos:',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.blueGrey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Dirección: ${pasantiaInfo['direccion']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  color: Colors.blueGrey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Teléfono: ${pasantiaInfo['telefono']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.mail,
                                  color: Colors.blueGrey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Correo: ${pasantiaInfo['correo']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                // Acción para subir hoja de vida
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.purple, // Color de fondo del botón
                                disabledForegroundColor:
                                    Colors.white, // Color del texto del botón
                                textStyle: const TextStyle(fontSize: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Borde redondeado
                                ),
                                elevation: 5, // Elevación para agregar sombra
                                padding: const EdgeInsets.all(
                                    16), // Espaciado interno del botón
                              ),
                              child: const Text('Postular'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final String? value;
  const ProfileInfoItem(this.title, this.value);
}