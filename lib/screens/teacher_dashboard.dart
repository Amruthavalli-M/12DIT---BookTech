import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; // For rendering SVG images (used for notification icon)
import '../models/bookings.dart'; // Booking data model
import '../widgets/my_bookings.dart'; // Widget that displays teacher's own bookings
import '../widgets/all_events.dart'; // Widget that displays all events available
import '../widgets/header_parts.dart'; // Custom header widget for page title/subtitle
import '../widgets/side_drawer.dart'; // Sidebar menu navigation widget
import '../widgets/notification_bar.dart'; // Notifications panel widget
import '../utils/responsive.dart'; // Utility for checking if device is desktop/tablet/mobile
import '../utils/size.config.dart'; // Utility for handling responsive sizing
import '../utils/theme.dart'; // Centralized color/theme definitions
import 'teacher_booking_form.dart'; // Teacher booking form screen
import 'package:booktech_flutter/api/booking_storage.dart'; // Persistent booking storage handler

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  // Key to control the Scaffold (allows opening/closing drawers programmatically)
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // Stores the list of bookings for this teacher (loaded from persistent storage)
  List<Booking> bookings = [];

  // Storage helper for reading/writing bookings to persistent storage
  final BookingStorage storage = BookingStorage();

  // Tracks which item in the side menu is currently selected (0 = Dashboard, 1 = Booking Form, etc.)
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBookings(); // Load any saved bookings as soon as dashboard is created
  }

  // Loads saved bookings from storage asynchronously
  Future<void> _loadBookings() async {
    final savedBookings = await storage.readBookings(); // Read from storage
    setState(() {
      bookings = savedBookings; // Update local list and rebuild UI
    });
  }

  // Adds a new booking both locally and to persistent storage
  void addBooking(Booking booking) async {
    setState(() {
      bookings.add(booking); // Add to in-memory list and refresh UI
    });
    await storage.writeBookings(bookings); // Save updated list to storage
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // Prepare responsive size calculations

    return Scaffold(
      key: drawerKey, // Needed for programmatic drawer opening
      backgroundColor: MyAppColor.backgroundColor, // Set background from theme

      // MOBILE/TABLET: Side navigation is shown as a drawer
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Narrow fixed-width drawer
              child: SideDrawerMenu(
                selectedIndex: selectedIndex, // Highlight active menu
                onItemSelected: (index) {
                  if (index == selectedIndex) return; // Do nothing if same item tapped

                  setState(() {
                    selectedIndex = index; // Change active menu index
                  });

                  if (index == 1) {
                    // If booking form selected, navigate to booking form screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherBookingForm(onBookingAdded: addBooking),
                      ),
                    );
                  } else {
                    // Other pages — just close the drawer
                    Navigator.pop(context);
                  }
                },
              ),
            )
          : null, // DESKTOP: Drawer not needed because permanent sidebar used

      // MOBILE/TABLET: Notifications are in an end drawer (right side)
      endDrawer: !Responsive.isDesktop(context)
          ? Drawer(
              child: const NotificationBar(), // Shows notification content
            )
          : null,

      // MOBILE/TABLET: App bar with hamburger and notification icon
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0, // No shadow
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer(); // Open side drawer
                },
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
              actions: [
                // Notification bell icon
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/dashboard/notification.svg', // Notification bell SVG
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    drawerKey.currentState!.openEndDrawer(); // Open notifications drawer
                  },
                ),
                const SizedBox(width: 12), // Extra spacing
              ],
            )
          : null, // DESKTOP: App bar not used

      // MAIN DASHBOARD BODY
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DESKTOP: Left-hand permanent sidebar
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1, // Sidebar takes 1/15 of width
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex, // Highlight current page
                  onItemSelected: (index) {
                    if (index == selectedIndex) return; // Ignore if same page clicked

                    setState(() {
                      selectedIndex = index; // Change active page
                    });

                    if (index == 1) {
                      // Navigate to booking form on desktop
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

            // MAIN CONTENT AREA (middle section)
            Expanded(
              flex: 10, // Main area is largest
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40, // Adjust for screen size
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page header
                    const HeaderParts(title: 'Teacher Dashboard'),

                    const SizedBox(height: 24),

                    // All available events
                    const AllEventsWidget(),

                    const SizedBox(height: 24),

                    // Teacher's own bookings list
                    MyBookingsWidget(bookings: bookings),
                  ],
                ),
              ),
            ),

            // DESKTOP: Right-hand notification panel
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 4, // Right column for notifications
                child: NotificationBar(),
              ),
          ],
        ),
      ),
    );
  }
}
