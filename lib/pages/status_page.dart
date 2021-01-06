import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandsnameapp/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("estatus"),
      ),
      body: Center(
        child: Text('Status ${socketService.serverStatus}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          socketService.socket.emit('emitir-mensaje',
              {'nombre': 'rubensito', 'mensaje': 'hola desde flutter'});
        },
      ),
    );
  }
}
