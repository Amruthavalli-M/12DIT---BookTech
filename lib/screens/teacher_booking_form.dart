import 'package:booktech_flutter/screens/teacher_dashboard.dart';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/size.config.dart';
import '../widgets/header_parts.dart';
import '../widgets/side_drawer.dart';
import '../utils/theme.dart';
import '../widgets/teacher_form_body.dart';

/// This widget represents the booking form page for teachers.
/// Teachers use this screen to submit requests for technical support.
/// The layout adapts depending on whether the user is on desktop, tablet, or mobile.
class TeacherBookingForm extends StatelessWidget {
  /// Key to control the Scaffold. Needed to open the drawer programmatically
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  TeacherBookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialise size configuration helper (used for responsive sizing)
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor, // Theme background color

      // Drawer navigation: Only visible on mobile/tablet
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100, // Drawer width on small screens
              child: SideDrawerMenu(
                onItemSelected: (index) {
                  // If the first item in the drawer is selected, go back to the Teacher Dashboard
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeacherDashboard()),
                    );
                  }
                },
              ),
            )
          : null,

      // AppBar: Only shown on mobile/tablet, contains hamburger menu icon
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  // Opens the sidebar drawer when menu icon is tapped
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
            // Left sidebar: visible only on desktop view
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  onItemSelected: (index) {
                    // Navigate back to Teacher Dashboard if first menu item clicked
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeacherDashboard()),
                      );
                    }
                  },
                ),
              ),

            // Main content area: Contains page header and booking form
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  // Adjust padding based on screen size
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderParts(), // Top header with page title/logo/etc.
                    SizedBox(height: 24),
                    TeacherFormBody(), // The actual booking form fields
                  ],
                ),
              ),
            ),

            // Right Panel: Maybe for notifications
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.amber, // Placeholder background color
                ),
              ),
          ],
        ),
      ),
    );
  }
}
