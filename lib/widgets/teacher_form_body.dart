import 'package:flutter/material.dart';

class TeacherFormBody extends StatefulWidget {
  const TeacherFormBody({super.key});

  @override
  State<TeacherFormBody> createState() => _TeacherFormBodyState();
}

class _TeacherFormBodyState extends State<TeacherFormBody> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store form field values
  String staffCode = '';
  String staffName = '';
  String dateOfEvent = '';
  String startTime = '';
  String endTime = '';
  String venue = '';
  String eventType = '';
  String techAssistance = '';
  String photographerRequired = 'No';

  // Validator for Staff Code: must be exactly 3 letters, no numbers or other chars
  String? _validateStaffCode(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    // Regex: exactly 3 letters (case-insensitive)
    if (!RegExp(r'^[A-Za-z]{3}$').hasMatch(value)) {
      return 'Staff code must be exactly 3 letters and no numbers';
    }
    return null;
  }

  // Validator for Staff Member Name: letters and spaces only, no digits or special chars
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    // Regex: only letters (uppercase or lowercase) and spaces allowed
    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
      return 'Name cannot contain numbers or special characters';
    }
    return null;
  }

  // Validator for Date of Event: must be in dd/mm/yyyy format and a valid date
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    // Basic format check: 2 digits / 2 digits / 4 digits
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'Date must be in dd/mm/yyyy format';
    }

    // Check if the date parts make a valid date
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // DateTime constructor normalizes invalid dates, so check components
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return 'Invalid date';
      }
    } catch (e) {
      return 'Invalid date';
    }

    return null;
  }

  // Validator for Start and End Time: must be in HH:mm 24-hour format
  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    // Regex: matches hours 00-23 and minutes 00-59
    if (!RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').hasMatch(value)) {
      return 'Time must be in HH:mm 24-hour format';
    }
    return null;
  }

  // Validator for Venue and Event Type: no digits allowed
  String? _validateNoDigits(String? value) {
    if (value == null || value.isEmpty) return 'Required';

    // Check if string contains any digit characters
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Does not accept integers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey, // Key to identify the form and perform validation
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tech Booking Form",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Staff Code input with custom validator
            _buildTextField(
              "Staff Code",
              onSaved: (val) => staffCode = val!,
              validator: _validateStaffCode,
            ),
            const SizedBox(height: 20),

            // Staff Member's Name input with custom validator
            _buildTextField(
              "Staff Member's Name",
              onSaved: (val) => staffName = val!,
              validator: _validateName,
            ),
            const SizedBox(height: 20),

            // Date of Event input with custom validator
            _buildTextField(
              "Date of Event (dd/mm/yyyy)",
              onSaved: (val) => dateOfEvent = val!,
              validator: _validateDate,
            ),
            const SizedBox(height: 20),

            // Start Time input with custom validator
            _buildTextField(
              "Start Time (HH:mm)",
              onSaved: (val) => startTime = val!,
              validator: _validateTime,
            ),
            const SizedBox(height: 20),

            // End Time input with custom validator
            _buildTextField(
              "End Time (HH:mm)",
              onSaved: (val) => endTime = val!,
              validator: _validateTime,
            ),
            const SizedBox(height: 20),

            // Venue input with validator forbidding digits
            _buildTextField(
              "Venue",
              onSaved: (val) => venue = val!,
              validator: _validateNoDigits,
            ),
            const SizedBox(height: 20),

            // Event Type input with validator forbidding digits
            _buildTextField(
              "Event Type",
              onSaved: (val) => eventType = val!,
              validator: _validateNoDigits,
            ),
            const SizedBox(height: 20),

            // Technical Assistance Requirements - multiline, basic required validation
            _buildTextField(
              "Technical Assistance Requirements",
              maxLines: 4,
              onSaved: (val) => techAssistance = val!,
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 20),

            // Photographer required radio buttons
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

            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate all fields using their validators
                  if (_formKey.currentState!.validate()) {
                    // Save form field values into variables
                    _formKey.currentState!.save();

                    // Show confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking submitted")),
                    );

                    // Reset the form fields
                    _formKey.currentState!.reset();

                    // Reset radio button value as well
                    setState(() {
                      photographerRequired = 'No';
                    });
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

  // Helper widget for creating labeled text fields with validation
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
      // Use provided validator or default 'required' validator
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
