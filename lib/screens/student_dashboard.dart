import 'package:booktech_flutter/utils/responsive.dart';  // Responsive helper for screen size checks
import 'package:booktech_flutter/utils/size.config.dart'; // Size configuration utility
import 'package:booktech_flutter/widgets/header_parts.dart'; // Header widget
import 'package:booktech_flutter/widgets/side_drawer.dart'; // Side drawer menu widget
import 'package:flutter/material.dart';
import 'package:booktech_flutter/utils/theme.dart'; // App color/theme definitions
import 'package:booktech_flutter/widgets/all_events.dart'; // Widget showing all events
import 'package:booktech_flutter/widgets/my_events.dart';  // Widget showing user's personal events
import 'package:booktech_flutter/widgets/volunteer.dart';  // Widget showing volunteer options

// Main Stateful widget for the Student Dashboard screen
class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  // Key to control the Scaffold, mainly to open/close the drawer programmatically
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // Tracks which menu item is currently selected in the SideDrawerMenu
  int selectedIndex = 0; // 0 is assumed to be the StudentDashboard index

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig for responsive sizing utilities
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey, // Assign the scaffold key

      // Set background color from app theme
      backgroundColor: MyAppColor.backgroundColor,

      // Show side drawer only on smaller screens (mobile/tablet)
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Keep drawer narrow on smaller devices
              child: SideDrawerMenu(
                selectedIndex: selectedIndex, // Highlight the current menu item
                onItemSelected: (index) {
                  if (index == selectedIndex) return; // If tapped current, do nothing

                  setState(() {
                    selectedIndex = index; // Update the selected index to highlight
                  });

                  // Navigate to the corresponding screen based on tapped index
                  if (index == 0) {
                    // For student dashboard - just close drawer since we are here
                    Navigator.pop(context);
                  } else if (index == 1) {
                    // Navigate to teacher dashboard
                    Navigator.pushReplacementNamed(context, '/teacherDashboard');
                  } else if (index == 2) {
                    // Navigate to leader dashboard
                    Navigator.pushReplacementNamed(context, '/leaderDashboard');
                  }
                },
              ),
            )
          : null, // No drawer on desktop - sidebar used instead

      // Show AppBar with hamburger menu only on non-desktop devices
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0, // Flat app bar
              backgroundColor: Colors.white, // White background
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer(); // Open drawer when tapped
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black, // Black icon color for contrast
                ),
              ),
            )
          : null, // No app bar on desktop

      // Main content area of the dashboard
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar menu shown only on desktop with selectedIndex and onItemSelected
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1, // Sidebar takes up 1 part of width ratio
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex, // Highlight current menu item
                  onItemSelected: (index) {
                    if (index == selectedIndex) return; // Do nothing if already selected

                    setState(() {
                      selectedIndex = index; // Update selection highlight
                    });

                    // Navigate to different screens based on tapped index
                    if (index == 0) {
                      // Already on student dashboard, so no navigation needed
                    } else if (index == 1) {
                      Navigator.pushReplacementNamed(context, '/teacherDashboard');
                    } else if (index == 2) {
                      Navigator.pushReplacementNamed(context, '/leaderDashboard');
                    }
                  },
                ),
              ),

            // Main dashboard content area, takes majority of width (flex:10)
            Expanded(
              flex: 10,
              child: SafeArea(
                child: SingleChildScrollView(
                  // Padding adjusts for mobile vs larger screens
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 20 : 40,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Header showing the dashboard title and subtitle
                      HeaderParts(title: "Student Dashboard"),
                      SizedBox(height: 24),

                      // Volunteer widget placeholder (empty for now)
                      VolunteerWidget(),
                      SizedBox(height: 24),

                      // My Events widget placeholder (empty for now)
                      MyEventsWidget(),
                      SizedBox(height: 24),

                      // All Events widget shows all events available
                      AllEventsWidget(),

                      // Additional Student Dashboard widgets can be added here
                    ],
                  ),
                ),
              ),
            ),

            // Right panel for desktop layout only
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.amber, // Placeholder background color for now
                ),
              ),
          ],
        ),
      ),
    );
  }
}
