import 'package:booktech_flutter/utils/responsive.dart';
import 'package:booktech_flutter/utils/size.config.dart';
import 'package:booktech_flutter/widgets/header_parts.dart';
import 'package:booktech_flutter/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:booktech_flutter/screens/teacher_booking_form.dart';
import 'package:booktech_flutter/utils/theme.dart';

class TeacherDashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      // Only show drawer on mobile/tablet
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100,
              child: SideDrawerMenu(
                onItemSelected: (index) {
                  if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeacherBookingForm()),
                    );
                  }
                },
              ),
            )
          : null,

      // AppBar for mobile/tablet
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
            // Sidebar for desktop
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  onItemSelected: (index) {
                    if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeacherBookingForm()),
                      );
                    }
                  },
                ),
              ),

            // Main content
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderParts(),
                    // More content here
                  ],
                ),
              ),
            ),

            // Right-side panel
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 4,
                child: SizedBox(), // Placeholder
              ),
          ],
        ),
      ),
    );
  }
}
