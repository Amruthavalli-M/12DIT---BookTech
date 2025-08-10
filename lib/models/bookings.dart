//Booking System storage structure

class Booking {
  final String staffCode;
  final String staffName;
  final String eventName;
  final String date;
  final String startTime;
  final String endTime;
  final String venue;
  final String techAssistance;
  final String photographerRequired;

  Booking({
    required this.staffCode,
    required this.staffName,
    required this.eventName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.techAssistance,
    required this.photographerRequired,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      staffCode: json['staffCode'],
      staffName: json['staffName'],
      eventName: json['eventName'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      venue: json['venue'],
      techAssistance: json['techAssistance'],
      photographerRequired: json['photographerRequired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staffCode': staffCode,
      'staffName': staffName,
      'eventName': eventName,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'venue': venue,
      'techAssistance': techAssistance,
      'photographerRequired': photographerRequired,
    };
  }
}
