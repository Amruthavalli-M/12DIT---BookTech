import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:booktech_flutter/models/bookings.dart';  // adjust path accordingly

class BookingStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bookings.json');
  }

  Future<List<Booking>> readBookings() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);

      return jsonList.map((jsonItem) => Booking.fromJson(jsonItem)).toList();
    } catch (e) {
      print('Error reading bookings file: $e');
      return [];
    }
  }

  Future<void> writeBookings(List<Booking> bookings) async {
    final file = await _localFile;
    final List<Map<String, dynamic>> jsonList = bookings.map((b) => b.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
