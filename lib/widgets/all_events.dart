import 'package:flutter/material.dart';
import 'package:booktech_flutter/models/events.dart';  // your event model & data
import '../utils/theme.dart';  // MyAppColor

class AllEventsWidget extends StatefulWidget {
  const AllEventsWidget({super.key});

  @override
  State<AllEventsWidget> createState() => _AllEventsWidgetState();
}

class _AllEventsWidgetState extends State<AllEventsWidget> {
  bool showAssemblies = false;

  @override
  Widget build(BuildContext context) {
    final filteredEvents = allEvents
        .where((event) => showAssemblies ? event.isAssembly : !event.isAssembly)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final theme = Theme.of(context);

    return Card(
      color: MyAppColor.secondaryBg, // light subtle background consistent with your theme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showAssemblies ? "Assemblies" : "Events",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: MyAppColor.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => showAssemblies = !showAssemblies),
                  style: TextButton.styleFrom(
                    foregroundColor: MyAppColor.primary,
                  ),
                  child: Text(showAssemblies ? "Show Events" : "Show Assemblies"),
                ),
              ],
            ),
            const SizedBox(height: 12),

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
              SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: filteredEvents.length,
                  separatorBuilder: (_, __) => Divider(
                    color: MyAppColor.barBg,
                  ),
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        event.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyAppColor.primary,
                        ),
                      ),
                      subtitle: Text(
                        "Date: ${_formatDate(event.date)}\nPeople on duty: ${event.members.join(', ')}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: MyAppColor.secondary,
                          height: 1.3,
                        ),
                      ),
                      isThreeLine: true,
                      leading: Icon(
                        showAssemblies ? Icons.group : Icons.event,
                        color: MyAppColor.primary,
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

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
