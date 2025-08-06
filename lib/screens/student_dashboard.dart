import 'package:booktech_flutter/utils/responsive.dart';
import 'package:booktech_flutter/utils/size.config.dart';
import 'package:booktech_flutter/widgets/header_parts.dart';
import 'package:booktech_flutter/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:booktech_flutter/utils/theme.dart';

class StudentDashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  StudentDashboard({super.key});

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
              child: const SideDrawerMenu(),
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
              const Expanded(
                flex: 1,
                child: SideDrawerMenu(),
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
