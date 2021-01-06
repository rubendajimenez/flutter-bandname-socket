import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io(
        'http://192.168.0.21:3001/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());
    this._socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    // socket.on('event', (data) => print(data));
    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print("Este es nombre : " + payload['nombre']);
      print("Este es mensaje :" + payload['mensaje']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    });

    // socket.on('fromServer', (_) => print(_));
  }
}
