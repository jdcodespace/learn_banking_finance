import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  // 1.
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      if (kDebugMode) {
        print(result);
      }
      checkStatus(result);
    });
  }

  // 2.
  void checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  // 3.
  void disposeStream() => _controller.close();
}