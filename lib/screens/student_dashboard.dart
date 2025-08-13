import 'package:booktech_flutter/utils/responsive.dart'; // Responsive file
import 'package:booktech_flutter/utils/size.config.dart'; // Screen sizing
import 'package:booktech_flutter/widgets/header_parts.dart'; // Heading
import 'package:booktech_flutter/widgets/side_drawer.dart'; // Nav side menu
import 'package:flutter/material.dart'; 
import 'package:booktech_flutter/utils/theme.dart'; // Colors
import 'package:booktech_flutter/widgets/all_events.dart';  // All events widget
import 'package:booktech_flutter/widgets/my_events.dart'; // My events widget
import 'package:booktech_flutter/widgets/volunteer.dart'; // Volunteer widget
import 'package:flutter_svg/svg.dart'; // SVG icons
import '../widgets/notification_bar.dart'; // Notification bar

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey(); // To control drawer

  int selectedIndex = 0; // Track which menu is selected

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // Initialise screen size

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      // Only show drawer on (mobile/tablet)
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Keep drawer narrow
              child: SideDrawerMenu(
                selectedIndex: selectedIndex, 
                onItemSelected: (index) async {
                  if (index == selectedIndex) return; // Ignore if already selected

                  setState(() {
                    selectedIndex = index;
                  });

                  Navigator.pop(context); // Close drawer
                  
                  if (index == 0) {
                    // Stay here
                  } else if (index == 2) {
                    Navigator.pushReplacementNamed(context, '/'); // Logout
                  }  
                },
              ),
            )
          : null,
      
      // mobile/tablet notification drawer
      endDrawer: !Responsive.isDesktop(context)
          ? Drawer(
            child: const NotificationBar(),
          )
        : null,

      // Only show AppBar (hamburger) on mobile/tablet
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer(); // Open left menu
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              actions: [
                // notification icon
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/dashboard/notification.svg',
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    drawerKey.currentState!.openEndDrawer(); // Open right drawer
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
            // Sidebar only on desktop
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex,
                  onItemSelected: (index) {
                    if (index == selectedIndex) return;

                    setState(() {
                      selectedIndex = index;
                    });

                    if (index == 0) {
                      // Already on StudentDashboard, no navigation needed
                    } else if (index == 2) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                ),
              ),

            // Main dashboard area
            Expanded(
              flex: 10,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 20 : 40,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HeaderParts(title: "Student Dashboard"),
                      SizedBox(height: 24),

                      VolunteerWidget(),
                      SizedBox(height: 24),

                      MyEventsWidget(),
                      SizedBox(height: 24),

                      AllEventsWidget(),  

                      // More widgets coming soon

                    ],
                  ),
                ),
              ),
            ),

            // Right side panel (desktop only)
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
