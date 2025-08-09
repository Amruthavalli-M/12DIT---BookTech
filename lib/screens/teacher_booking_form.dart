import 'package:flutter/material.dart';
import '../models/bookings.dart';
import '../widgets/header_parts.dart';  
import '../widgets/side_drawer.dart';
import '../utils/responsive.dart';
import '../utils/size.config.dart';
import '../utils/theme.dart';
import 'package:booktech_flutter/widgets/teacher_form_body.dart';
import 'package:booktech_flutter/screens/teacher_dashboard.dart';

class TeacherBookingForm extends StatelessWidget {
  final void Function(Booking) onBookingAdded;
  final int selectedIndex = 1; // Booking form is menu index 1
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  TeacherBookingForm({super.key, required this.onBookingAdded});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: MyAppColor.backgroundColor,

      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 100,
              child: SideDrawerMenu(
                selectedIndex: selectedIndex,
                onItemSelected: (index) {
                  if (index == selectedIndex) return;

                  if (index == 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherDashboard(),
                      ),
                    );
                  }
                },
              ),
            )
          : null,

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
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideDrawerMenu(
                  selectedIndex: selectedIndex,
                  onItemSelected: (index) {
                    if (index == selectedIndex) return;

                    if (index == 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherDashboard(),
                        ),
                      );
                    }
                  },
                ),
              ),

            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderParts(), // <--- HERE IT IS!
                    const SizedBox(height: 24),
                    TeacherFormBody(onBookingAdded: onBookingAdded),
                  ],
                ),
              ),
            ),

            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/lightlogo.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              ),
          ],
        ),
      ),
    );
  }
}
