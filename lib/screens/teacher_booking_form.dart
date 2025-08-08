import 'package:flutter/material.dart';
import '../models/bookings.dart';
import '../widgets/header_parts.dart';  // keep this import
import '../widgets/side_drawer.dart';
import '../utils/responsive.dart';
import '../utils/size.config.dart';
import '../utils/theme.dart';
import 'package:booktech_flutter/widgets/teacher_form_body.dart';

class TeacherBookingForm extends StatelessWidget {
  final void Function(Booking) onBookingAdded;
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
                onItemSelected: (index) {
                  if (index == 0) {
                    Navigator.pop(context);
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
                  onItemSelected: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
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
                child: Container(color: Colors.amber),
              ),
          ],
        ),
      ),
    );
  }
}
