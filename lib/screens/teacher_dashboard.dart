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


/// Main dashboard screen for Teachers
/// Displays events, bookings and notifications
class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  // Controls the scaffold
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // List of booking objects representing bookings for teachers
  List<Booking> bookings = [];

  // Reads and writes bookings to storage JSON
  final BookingStorage storage = BookingStorage();

  // Tracks which item in side bar is selected
  int selectedIndex = 0; // 0 = Dashboard

  @override
  void initState() {
    super.initState();
    _loadBookings(); // Load bookings from storage when dashboard initialises
  }

  /// Loads saved bookings from storage
  /// Updates the local bookings list and refreshes UI
  Future<void> _loadBookings() async {
    final savedBookings = await storage.readBookings();
    setState(() {
      bookings = savedBookings;
    });
  }

  /// Adds a new booking to the list and saves it to storage
  void addBooking(Booking booking) async {
    setState(() {
      bookings.add(booking);
    });
    await storage.writeBookings(bookings);
  }

  @override
  Widget build(BuildContext context) {
    // Initialises responsive size 
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor, 

      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100,
              child: SideDrawerMenu(
                selectedIndex: selectedIndex, // Highlights selected item
                onItemSelected: (index) {
                  if (index == selectedIndex) return; // Do nothing if same

                  setState(() {
                    selectedIndex = index; // Update active selection
                  });

                  // Navigate based on selected menu item
                  if (index == 1) {
                    // Navigate to TeacherBookingForm when index 1 is selected
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherBookingForm(onBookingAdded: addBooking),
                      ),
                    );
                  } else {
                    // Close drawer for other selections
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

      /// AppBar for mobile/tablet
      /// Contains hamburger and noticiatoin icon
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer(); // Open side drawer
                },
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
              actions: [
                // Notification icon opens endDrawer
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
                const SizedBox(width: 12), // Spacing from edge
              ],
            )
          : null,

      /// Main dashboard body
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar for desktop view
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex,
                  onItemSelected: (index) {
                    if (index == selectedIndex) return; // Already active

                    setState(() {
                      selectedIndex = index; // Update selected menu item
                    });

                    // Navigate to TeacherBookingForm if index 1 selected
                    if (index == 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherBookingForm(onBookingAdded: addBooking),
                        ),
                      );
                    }
                  },
                ),
              ),

            // Main content area
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
                    // Header showing dashboard title and subtitle
                    const HeaderParts(title: 'Teacher Dashboard'),
                    
                    const SizedBox(height: 24),

                    // All events read only
                    const AllEventsWidget(),   

                    const SizedBox(height: 24),
                    
                    // Teacher bookings (My bookings)
                    MyBookingsWidget(bookings: bookings),
                  ],
                ),
              ),
            ),

            // Desktop notification panel
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
