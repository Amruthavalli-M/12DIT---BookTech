// events.dart

class Event {
  final String name;
  final DateTime date;
  final List<String> members;
  final bool isAssembly;

  Event({
    required this.name,
    required this.date,
    required this.members,
    required this.isAssembly,
  });
}

// List of events and assemblies
final List<Event> allEvents = [
  Event(
    name: "Junior Assembly",
    date: DateTime(10, 8, 2025),
    members: ["Amrutha", "Vaishnavi"],
    isAssembly: true,
  ),
  Event(
    name: "Trivia Night",
    date: DateTime(12, 8, 2025),
    members: ["Zoe", "Kristina"],
    isAssembly: false,
  ),
  Event(
    name: "Senior Assembly",
    date: DateTime(15, 8, 2025),
    members: ["Advika", "Karen"],
    isAssembly: true,
  ),
];
