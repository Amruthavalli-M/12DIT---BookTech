import 'package:flutter/material.dart';
import '../models/bookings.dart'; 
import '../utils/theme.dart';     

// Display a list of the teacher's bookings
class MyBookingsWidget extends StatelessWidget {
  // List of bookings passed from parent widget
  final List<Booking> bookings;

  const MyBookingsWidget({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Card(
      elevation: 5,
      color: MyAppColor.secondaryBg, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
        side: BorderSide(
          color: MyAppColor.primary,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), // Margin around card

      child: Padding(
        padding: const EdgeInsets.all(24), // Inner padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children left
          children: [
            // Header text for the section
            Text(
              "My Bookings",
              style: theme.textTheme.titleLarge?.copyWith(
                color: MyAppColor.secondary,     
                fontWeight: FontWeight.w700,    // Semi bold text
              ),
            ),
            const SizedBox(height: 12), // Space below header

            // Conditional display depending on whether bookings list is empty
            bookings.isEmpty
                ? Text(
                    "You have no bookings yet.", // Message when no bookings
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: MyAppColor.secondary,  
                      fontStyle: FontStyle.italic,  // Italic 
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,               // Let ListView shrink to fit content
                    physics: const NeverScrollableScrollPhysics(), // Disable scrolling (parent scrolls)
                    itemCount: bookings.length,    // Number of booking items
                    separatorBuilder: (_, __) => Divider(color: MyAppColor.barBg), // Divider between items
                    itemBuilder: (context, index) {
                      final booking = bookings[index]; // Current booking to display

                      return ListTile(
                        contentPadding: EdgeInsets.zero, // Remove default padding
                        title: Text(
                          booking.eventName, // Event name of booking
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600, // Medium bold
                            color: MyAppColor.secondary,   //  color
                          ),
                        ),
                        subtitle: Text(
                          // Multi line subtitle 
                          "Date: ${booking.date}\nVenue: ${booking.venue}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: MyAppColor.secondary, 
                            height: 1.3, // Line height spacing
                          ),
                        ),
                        isThreeLine: true, // Allow subtitle to span 3 lines
                        leading: Icon(Icons.book_online, color: MyAppColor.secondary), // Icon representing booking
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
