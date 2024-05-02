import 'package:flutter/material.dart';
import 'package:paramov/components/notification_service.dart';

var val1;
var val2;
var val3;
var val4;

String? ttl;
String? bd;
Future nmethod(
    @required val1, @required val2, @required val3, @required val4) async {
  if (val1 > 11) {
    ttl = "I need Assisstance!";
    bd = "Please Call the Caretaker";
    await NotificationController.createNewNotification(ttl, bd);
  }
  if (val2 > 23) {
    ttl = "I am thirsty!";
    bd = "Please! Give the water";
    await NotificationController.createNewNotification(ttl, bd);
  }
  if (val3 > 23) {
    ttl = "I am Hungary!";
    bd = "Please! Give the food";
    await NotificationController.createNewNotification(ttl, bd);
  }
  if (val4 > 23) {
    ttl = "I want to go to the restroom!";
    bd = "Please! Call the Caretaker";
    await NotificationController.createNewNotification(ttl, bd);
  }
}
