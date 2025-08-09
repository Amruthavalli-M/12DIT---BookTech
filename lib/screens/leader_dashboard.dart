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
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  int selectedIndex = 2; // Assuming 2 is the index for LeaderDashboard in your menuIcons list

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      // Only show drawer on non-desktop (mobile/tablet)
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Keep drawer narrow
              child: SideDrawerMenu(
                selectedIndex: selectedIndex,
                onItemSelected: (index) {
                  if (index == selectedIndex) return; // do nothing if already selected

                  setState(() {
                    selectedIndex = index;
                  });

                  // Navigate to appropriate screen based on index
                  if (index == 0) {
                    Navigator.pushReplacementNamed(context, '/teacherDashboard');
                  } else if (index == 1) {
                    Navigator.pushReplacementNamed(context, '/teacherBookingForm');
                  } else if (index == 2) {
                    // Already on LeaderDashboard, do nothing or maybe Navigator.pop
                    Navigator.pop(context);
                  }
                  // Add other cases if you have more menu items
                },
              ),
            )
          : null,

      // Only show AppBar (hamburger) on mobile/tablet
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
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
                      Navigator.pushReplacementNamed(context, '/teacherDashboard');
                    } else if (index == 1) {
                      Navigator.pushReplacementNamed(context, '/teacherBookingForm');
                    } else if (index == 2) {
                      // Already on LeaderDashboard, do nothing or Navigator.pop maybe
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderParts(),
                      // Add more content here
                    ],
                  ),
                ),
              ),
            ),

            // Right-side panel (desktop only)
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.amber,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
