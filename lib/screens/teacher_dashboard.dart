import 'package:flutter/material.dart';
import '../models/bookings.dart';
import '../widgets/my_bookings.dart';
import '../widgets/all_events.dart';          
import '../widgets/header_parts.dart';
import '../widgets/side_drawer.dart';
import '../utils/responsive.dart';
import '../utils/size.config.dart';
import '../utils/theme.dart';
import 'teacher_booking_form.dart';

class TeacherDashboard extends StatefulWidget {
  TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  List<Booking> bookings = [];

  // Add booking and update UI
  void addBooking(Booking booking) {
    setState(() {
      bookings.add(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100,
              child: SideDrawerMenu(
                onItemSelected: (index) {
                  if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherBookingForm(onBookingAdded: addBooking),
                      ),
                    );
                  } else {
                    // Close drawer for other items
                    Navigator.pop(context);
                  }
                },
              ),
            )
          : null,

      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
            )
          : null,

      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  onItemSelected: (index) {
                    if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherBookingForm(onBookingAdded: addBooking),
                        ),
                      );
                    }
                  },
                ),
              ),

            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderParts(),

                    const SizedBox(height: 24),

                    const AllEventsWidget(),   

                    const SizedBox(height: 24),

                    MyBookingsWidget(bookings: bookings),
                  ],
                ),
              ),
            ),

            if (Responsive.isDesktop(context))
               Expanded(
                flex: 4,
                child: Container(
                  color: Colors.amber
                ),
              ),
          ],
        ),
      ),
    );
  }
}
