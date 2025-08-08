import 'package:flutter/material.dart';
import '../models/bookings.dart';

class TeacherFormBody extends StatefulWidget {
  final void Function(Booking) onBookingAdded;

  const TeacherFormBody({super.key, required this.onBookingAdded});

  @override
  State<TeacherFormBody> createState() => _TeacherFormBodyState();
}

class _TeacherFormBodyState extends State<TeacherFormBody> {
  final _formKey = GlobalKey<FormState>();

  String staffCode = '';
  String staffName = '';
  String dateOfEvent = '';
  String startTime = '';
  String endTime = '';
  String venue = '';
  String eventType = '';
  String techAssistance = '';
  String photographerRequired = 'No';

  String? _validateStaffCode(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[A-Za-z]{3}$').hasMatch(value)) {
      return 'Staff code must be exactly 3 letters and no numbers';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
      return 'Name cannot contain numbers or special characters';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'Date must be in dd/mm/yyyy format';
    }

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

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    if (!RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').hasMatch(value)) {
      return 'Time must be in HH:mm 24-hour format';
    }
    return null;
  }

  String? _validateNoDigits(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    if (RegExp(r'\d').hasMatch(value)) {
      return 'Does not accept integers';
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
              onSaved: (val) => startTime = val!,
              validator: _validateTime,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "End Time (HH:mm)",
              onSaved: (val) => endTime = val!,
              validator: _validateTime,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Venue",
              onSaved: (val) => venue = val!,
              validator: _validateNoDigits,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Event Type",
              onSaved: (val) => eventType = val!,
              validator: _validateNoDigits,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Technical Assistance Requirements",
              maxLines: 4,
              onSaved: (val) => techAssistance = val!,
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
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
                onPressed: () {
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

                    widget.onBookingAdded(newBooking);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking submitted")),
                    );

                    _formKey.currentState!.reset();

                    setState(() {
                      photographerRequired = 'No';
                    });

                    Navigator.of(context).pop(); // POP back to TeacherDashboard
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text("Submit"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    int maxLines = 1,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
