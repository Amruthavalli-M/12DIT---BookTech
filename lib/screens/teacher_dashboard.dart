import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/bookings.dart';
import '../widgets/my_bookings.dart';
import '../widgets/all_events.dart';          
import '../widgets/header_parts.dart';
import '../widgets/side_drawer.dart';
import '../widgets/notification_bar.dart';
import '../utils/responsive.dart';
import '../utils/size.config.dart';
import '../utils/theme.dart';
import 'teacher_booking_form.dart';
import 'package:booktech_flutter/api/booking_storage.dart';  

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  List<Booking> bookings = [];

  final BookingStorage storage = BookingStorage();

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final savedBookings = await storage.readBookings();
    setState(() {
      bookings = savedBookings;
    });
  }

  void addBooking(Booking booking) async {
    setState(() {
      bookings.add(booking);
    });
    await storage.writeBookings(bookings);
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
                  if (index == 1) {
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

      // endDrawer for notification panel on mobile/tablet
      endDrawer: !Responsive.isDesktop(context)
          ? Drawer(
              child: const NotificationBar(),
            )
          : null,

      // appBar to include notification icon on mobile/tablet
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
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/dashboard/notification.svg',
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    drawerKey.currentState!.openEndDrawer();
                  },
                ),
                const SizedBox(width: 12),
              ],
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
                    if (index == 1) {
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

            // right notification panel on desktop
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 4,
                child: NotificationBar(),
              ),
          ],
        ),
      ),
    );
  }
}
