import 'package:booktech_flutter/utils/responsive.dart';
import 'package:booktech_flutter/utils/size.config.dart';
import 'package:booktech_flutter/widgets/header_parts.dart';
import 'package:booktech_flutter/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:booktech_flutter/utils/theme.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  int selectedIndex = 0; // Assuming 0 is StudentDashboard index

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
                  if (index == selectedIndex) return; // already selected

                  setState(() {
                    selectedIndex = index;
                  });

                  // Navigate based on index, example:
                  if (index == 0) {
                    // Already on StudentDashboard, just close drawer
                    Navigator.pop(context);
                  } else if (index == 1) {
                    Navigator.pushReplacementNamed(context, '/teacherDashboard');
                  } else if (index == 2) {
                    Navigator.pushReplacementNamed(context, '/leaderDashboard');
                  }
                  // add more as needed
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
                      // Already on StudentDashboard, no navigation needed
                    } else if (index == 1) {
                      Navigator.pushReplacementNamed(context, '/teacherDashboard');
                    } else if (index == 2) {
                      Navigator.pushReplacementNamed(context, '/leaderDashboard');
                    }
                    // Add more if needed
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
                      // Add your Student Dashboard content here
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
