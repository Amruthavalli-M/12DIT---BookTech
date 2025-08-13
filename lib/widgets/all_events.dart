import 'package:flutter/material.dart';
import 'package:booktech_flutter/models/events.dart';  
import '../utils/theme.dart';  

class AllEventsWidget extends StatefulWidget {
  const AllEventsWidget({super.key});

  @override
  State<AllEventsWidget> createState() => _AllEventsWidgetState();
}

class _AllEventsWidgetState extends State<AllEventsWidget> {
  // Controls whether to show assemblies or regular events
  bool showAssemblies = false;

  @override
  Widget build(BuildContext context) {
    // Filter events based on showAssemblies flag:
    // if true, show only assemblies; otherwise, (events)
    final filteredEvents = allEvents
        .where((event) => showAssemblies ? event.isAssembly : !event.isAssembly)
        .toList()
      // Sort the filtered list by date ascending
      ..sort((a, b) => a.date.compareTo(b.date));

    final theme = Theme.of(context); // Theme

    return Card(
      color: MyAppColor.secondaryBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners on the card
        side: BorderSide(
          color: MyAppColor.primary,
          width: 2,
        ),
      ),
      elevation: 5, // Shadow depth 
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), // Outer spacing

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24), // Inner padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title and filter button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title shows either Assemblies or Events depending on state
                Text(
                  showAssemblies ? "Assemblies" : "Events",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: MyAppColor.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // Button switches between showing assemblies or events
                TextButton(
                  onPressed: () => setState(() => showAssemblies = !showAssemblies),
                  style: TextButton.styleFrom(
                    foregroundColor: MyAppColor.primary,
                  ),
                  child: Text(showAssemblies ? "Show Events" : "Show Assemblies"),
                ),
              ],
            ),

            const SizedBox(height: 12), // Spacing between header and list

            // Show message if no events/assemblies found
            if (filteredEvents.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "No ${showAssemblies ? 'assemblies' : 'events'} found.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: MyAppColor.secondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              // List of filtered events/assemblies
              SizedBox(
                height: 300, // Fixed height for scrolling list
                child: ListView.separated(
                  itemCount: filteredEvents.length, // Number of items in the list
                  separatorBuilder: (_, __) => Divider(
                    color: MyAppColor.barBg, // Divider color between list items
                  ),
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index]; // Current event

                    return ListTile(
                      contentPadding: EdgeInsets.zero, // Remove default padding
                      title: Text(
                        event.name, // Event name/title
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyAppColor.secondary,
                        ),
                      ),
                      subtitle: Text(
                        // Date formatted and members on duty listed
                        "Date: ${_formatDate(event.date)}\nPeople on duty: ${event.members.join(', ')}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: MyAppColor.secondary,
                          height: 1.3,
                        ),
                      ),
                      isThreeLine: true, // Multiline subtitle
                      leading: Icon(
                        // Shows group for assemblies, event icon otherwise
                        showAssemblies ? Icons.group : Icons.event,
                        color: MyAppColor.secondary,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to format DateTime as DD/MM/YYYY string
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
