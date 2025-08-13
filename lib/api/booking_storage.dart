import 'dart:io'; // Access to file system
import 'dart:convert'; //Convert data between dart to Json and vice versa
import 'package:path_provider/path_provider.dart'; // Flutter plugin to find common filesystem locations on device
import 'package:booktech_flutter/models/bookings.dart';  

class BookingStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  // Builds full file path for bookings.json
  // returns a file object 
  Future<File> get _localFile async {
    final path = await _localPath; // get documents folder path
    return File('$path/bookings.json'); // append file name
  }


 // If the file doesn't exist yet, returns an empty list.
  // If the file exists, loads the JSON, converts it into Booking objects, and returns the list.
  Future<List<Booking>> readBookings() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        return [];
      }
 

      // Read file as a string
      final contents = await file.readAsString();
      // Decode the JSON string into a list of objects
      final List<dynamic> jsonList = json.decode(contents);

       // Map each JSON object into a Booking instance
      return jsonList.map((jsonItem) => Booking.fromJson(jsonItem)).toList();
    } catch (e) {
      print('Error reading bookings file: $e'); // // If something goes wrong (e.g., corrupted file), log it and return empty list
      return [];
    }
  }

  // Convert each Booking object into a Map, then make a list of them

  Future<void> writeBookings(List<Booking> bookings) async {
    final file = await _localFile;
    final List<Map<String, dynamic>> jsonList = bookings.map((b) => b.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
