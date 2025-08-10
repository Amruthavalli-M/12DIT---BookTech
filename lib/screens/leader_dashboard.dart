import 'package:booktech_flutter/utils/responsive.dart';
import 'package:booktech_flutter/utils/size.config.dart';
import 'package:booktech_flutter/widgets/header_parts.dart';
import 'package:booktech_flutter/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:booktech_flutter/utils/theme.dart';

class LeaderDashboard extends StatefulWidget {
  const LeaderDashboard({super.key});

  @override
  State<LeaderDashboard> createState() => _LeaderDashboardState();
}

class _LeaderDashboardState extends State<LeaderDashboard> {
  // Key to control the Scaffold state 
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // Tracks the currently selected menu item index (2 = LeaderDashboard)
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    // Initialise SizeConfig for responsive layout calculations
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      // Drawer shown only on mobile/tablet (non-desktop)
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Drawer width narrow for menu icons only
              child: SideDrawerMenu(
                selectedIndex: selectedIndex, // Pass current selection to highlight active item
                onItemSelected: (index) {
                  if (index == selectedIndex) return; // Ignore taps on the current item

                  setState(() {
                    selectedIndex = index; // Update selected index state
                  });

                  // Navigate to screens based on selected index
                  if (index == 0) {
                    Navigator.pushReplacementNamed(context, '/teacherDashboard');
                  } else if (index == 1) {
                    Navigator.pushReplacementNamed(context, '/teacherBookingForm');
                  } else if (index == 2) {
                    // Already on LeaderDashboard, so just close the drawer
                    Navigator.pop(context);
                  }
                  // Additional menu item navigation cases can be added here if needed
                },
              ),
            )
          : null, // No drawer on desktop because sidebar is always visible

      // AppBar with hamburger menu only shown on mobile/tablet
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer(); // Opens drawer when hamburger is pressed
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            )
          : null, // No AppBar on desktop, sidebar is permanent

      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar menu shown only on desktop screens
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1, // Sidebar takes up 1 part of the horizontal space
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex, // Highlight current active menu item
                  onItemSelected: (index) {
                    if (index == selectedIndex) return; // Ignore selecting current page

                    setState(() {
                      selectedIndex = index; // Update selected index
                    });

                    // Navigate based on selected menu item
                    if (index == 0) {
                      Navigator.pushReplacementNamed(context, '/teacherDashboard');
                    } else if (index == 1) {
                      Navigator.pushReplacementNamed(context, '/teacherBookingForm');
                    } else if (index == 2) {
                      // Already on LeaderDashboard, do nothing or optionally close any overlays
                    }
                  },
                ),
              ),

            // Main content area of the dashboard
            Expanded(
              flex: 10, // Main content takes up 10 parts (larger area)
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 20 : 40,
                    vertical: 10,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderParts(title: "Leader Dashboard"), // Header with dynamic title
                      // Additional dashboard content can be added here
                    ],
                  ),
                ),
              ),
            ),

            // Right side panel shown only on desktop (flex: 4)
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.amber, // Placeholder color for right panel
                ),
              ),
          ],
        ),
      ),
    );
  }
}
