import 'package:booktech_flutter/utils/responsive.dart';
import 'package:booktech_flutter/utils/size.config.dart';
import 'package:booktech_flutter/widgets/header_parts.dart';
import 'package:booktech_flutter/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:booktech_flutter/utils/theme.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/notification_bar.dart';

class LeaderDashboard extends StatefulWidget {
  const LeaderDashboard({super.key});

  @override
  State<LeaderDashboard> createState() => _LeaderDashboardState();
}

class _LeaderDashboardState extends State<LeaderDashboard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  int selectedIndex = 0; // For the second icon

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
                  if (index == selectedIndex) {
                    return; // do nothing if already selected
                  }
                  
                  setState(() {
                    selectedIndex = index;
                  });

                  // Navigate to appropriate screen based on index
                  if (index == 0) {
                  // Already on LeaderDashboard, do nothing   
                  } else if (index == 2) {
                    Navigator.pushReplacementNamed (context, '/');
                  }
                },
              ),
            )
          : null,

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
                  drawerKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              actions: [
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
                      // Already on LeaderDashboard, do nothing 
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderParts(title: "Leader Dashboard"),
                      // Add more content here
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
