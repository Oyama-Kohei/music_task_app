import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
abstract class ServiceListener{
  Future<void> onServiceEventRaised(dynamic service, dynamic event);
}
class Service {
  final List<ServiceListener> listener = [];

  static T of<T extends Service>(BuildContext context){
    return Provider.of<T>(context, listen: false);
  }
}