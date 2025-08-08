import 'package:flutter/material.dart';
import '../models/bookings.dart';
import '../utils/theme.dart';

class MyBookingsWidget extends StatelessWidget {
  final List<Booking> bookings;

  const MyBookingsWidget({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: MyAppColor.secondaryBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Bookings",
              style: theme.textTheme.titleLarge?.copyWith(
                color: MyAppColor.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            bookings.isEmpty
                ? Text(
                    "You have no bookings yet.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: MyAppColor.secondary,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    separatorBuilder: (_, __) => Divider(color: MyAppColor.barBg),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          booking.eventName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyAppColor.primary,
                          ),
                        ),
                        subtitle: Text(
                          "Date: ${booking.date}\nVenue: ${booking.venue}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: MyAppColor.secondary,
                            height: 1.3,
                          ),
                        ),
                        isThreeLine: true,
                        leading: Icon(Icons.book_online, color: MyAppColor.primary),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
