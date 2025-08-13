import 'package:booktech_flutter/api/booking_storage.dart';
import 'package:booktech_flutter/screens/teacher_dashboard.dart';
import 'package:booktech_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import '../models/bookings.dart';

class TeacherFormBody extends StatefulWidget {
  final void Function(Booking) onBookingAdded;

  const TeacherFormBody({super.key, required this.onBookingAdded});

  @override
  State<TeacherFormBody> createState() => _TeacherFormBodyState();
}

/// Stateful widget for teacher booking form
/// Allows teachers to submit tech assistance requests for events
class _TeacherFormBodyState extends State<TeacherFormBody> {
  // Callback funtion to notifyparent widget when new booking
  final _formKey = GlobalKey<FormState>();


// Form fields
  String staffCode = '';
  String staffName = '';
  String dateOfEvent = '';
  String startTime = '';
  String endTime = '';
  String venue = '';
  String eventType = '';
  String techAssistance = '';
  String photographerRequired = 'No';
  

  // ========================= Validation Methods =========================


// Staff Code Validation
  String? _validateStaffCode(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[A-Za-z]{3}$').hasMatch(value)) {
      return 'Staff code must be exactly 3 letters and no numbers';
    }
    return null;
  }

// Staff Name Validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
      return 'Name cannot contain numbers or special characters';
    }

    if (value.length > 50) {
      return 'Name must be under 50 characters';
    } 

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

// Date Validation
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    // Check for letters
    if (RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Date cannot contain letters';
    }

    // Check for special characters other than slash and digits
    if (RegExp(r'[^0-9/]').hasMatch(value)) {
      return 'Date cannot contain special characters';
    }

    // Check for date format
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'Date must be in dd/mm/yyyy format';
    }

    // Check for valid date
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return 'Invalid date';
      }
    } catch (e) {
      return 'Invalid date';
    }

    return null;
  }

  // Variabes for time
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

// Time Validation
  String? _validateTime(String? value, {bool isEndTime = false}) {
    if (value == null || value.isEmpty) return 'Required';

    // Check for letters
    if (RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Time cannot contain letters';
    }

     // Check for special characters other than colon
    if (RegExp(r'[^0-9:]').hasMatch(value)) {
      return 'Time cannot contain special characters';
    }

    // Format Checker
    if (!RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').hasMatch(value)) {
      return 'Time must be in HH:mm 24-hour format';
    }

    // Rule for end time: at least 30 mins later than start
    if (isEndTime && _startTimeController.text.isNotEmpty) {
      try {
        final startParts = _startTimeController.text.split(':').map(int.parse).toList();
        final endParts = value.split(':').map(int.parse).toList();

        final startMinutes = startParts[0] * 60 + startParts[1];
        final endMinutes = endParts[0] * 60 + endParts[1];

        if (endMinutes - startMinutes < 30) {
          return 'Booking must be at least 30 minutes long';
        }
      } catch (e) {
        return 'Invalid time format';
      }
    }
    
    return null;
  }


  // Venue Validation
  String? _validateVenue(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    // Reject digits
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Venue does not accept integers';
    }

    // Reject special characters (anything except letters and spaces)
    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
      return 'Venue cannot contain special characters';
    }

    if (value.length > 50) {
      return 'Venue must be under 50 characters';
    }

    if (value.length < 3) {
      return 'Venue must be at least 3 characters';
    }

    return null;
  }

  // Event Type Validation
  String? _validateEventType(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    if (RegExp(r'\d').hasMatch(value)) {
      return 'Event type cannot contain numbers';
    }

    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
      return 'Event type cannot contain special characters';
    }

    if (value.length > 50) {
      return 'Event Type must be under 50 characters';
    }

    if (value.length < 3) {
      return 'Event Type must be at least 3 characters';
    }

    return null;
  }

// Requirements Validation
String? _validateTech(String? value) {
  if (value == null || value.isEmpty) return 'Required';

  if (value.length > 500) {
    return 'You have exceeded the limit of 500 characters';
  }

  if (value.length < 50) {
    return 'Please write a minimum of 50 characters';
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tech Booking Form",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            _buildTextField(
              "Staff Code",
              onSaved: (val) => staffCode = val!,
              validator: _validateStaffCode,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Staff Member's Name",
              onSaved: (val) => staffName = val!,
              validator: _validateName,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Date of Event (dd/mm/yyyy)",
              onSaved: (val) => dateOfEvent = val!,
              validator: _validateDate,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Start Time (HH:mm)",
              controller: _startTimeController,
              onSaved: (val) => startTime = val!,
              validator: (value) => _validateTime(value),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "End Time (HH:mm)",
              controller: _endTimeController,
              onSaved: (val) => endTime = val!,
              validator: (value) => _validateTime(value, isEndTime: true),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Venue",
              onSaved: (val) => venue = val!,
              validator: _validateVenue,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Event Type",
              onSaved: (val) => eventType = val!,
              validator: _validateEventType,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Technical Assistance Requirements",
              maxLines: 4,
              onSaved: (val) => techAssistance = val!,
              validator: _validateTech,
            ),
            const SizedBox(height: 20),

            const Text("School Photographer Required?"),
            Row(
              children: [
                Radio<String>(
                  value: 'Yes',
                  groupValue: photographerRequired,
                  onChanged: (value) => setState(() => photographerRequired = value!),
                ),
                const Text('Yes'),
                Radio<String>(
                  value: 'No',
                  groupValue: photographerRequired,
                  onChanged: (value) => setState(() => photographerRequired = value!),
                ),
                const Text('No'),
              ],
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newBooking = Booking(
                      staffCode: staffCode,
                      staffName: staffName,
                      eventName: eventType,
                      date: dateOfEvent,
                      startTime: startTime,
                      endTime: endTime,
                      venue: venue,
                      techAssistance: techAssistance,
                      photographerRequired: photographerRequired,
                    );

                    // Save to persistent storage
                    final storage = BookingStorage();
                    List<Booking> currentBookings = await storage.readBookings();
                    currentBookings.add(newBooking);
                    await storage.writeBookings(currentBookings);

                    widget.onBookingAdded(newBooking);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking submitted")),
                    );

                    _formKey.currentState!.reset();

                    setState(() {
                      photographerRequired = 'No';
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherDashboard(),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    int maxLines = 1,
    TextEditingController? controller,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction, // I added this line
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyAppColor.primary,
            width: 2,
          ),
        ),
      ),
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
