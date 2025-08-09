import 'package:booktech_flutter/models/model.dart';
import 'package:booktech_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Side navigation drawer used in the app.
/// Shows a vertical list of menu icons with a visual highlight for the selected one.
/// Supports an `onItemSelected` to tell the parent which menu item was tapped.
class SideDrawerMenu extends StatelessWidget {
  /// Function to run when a menu item is tapped passes the tapped item's index.
  final Function(int)? onItemSelected;

  /// The index of the currently selected menu item (controlled by parent)
  final int selectedIndex;

  const SideDrawerMenu({
    super.key,
    this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0, // No shadow around the drawer
      child: Container(
        // Drawer background color from theme
        decoration: const BoxDecoration(color: MyAppColor.secondaryBg),
        child: SingleChildScrollView(
          // Allows scrolling if there are many menu items
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Logo section at the top of the drawer
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  width: 25,
                  child: SvgPicture.asset("assets/dashboard/logo.svg"), // TODO: Add actual logo SVG path
                ),
              ),

              // Generate a menu item widget for each icon in the menuIcons list
              ...List.generate(menuIcons.length, (index) {
                return GestureDetector(
                  onTap: () {
                    if (onItemSelected != null) {
                      onItemSelected!(index);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: Colors.transparent, // Keeps background clear
                    child: Row(
                      children: [
                        // Menu icon, centered horizontally
                        Expanded(
                          child: Center(
                            child: SvgPicture.asset(
                              menuIcons[index], // Icon path from menuIcons list
                              color: selectedIndex == index
                                  ? Colors.black // Active color
                                  : MyAppColor.iconGray, // Inactive color
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),

                        // Thin right side bar showing the active selection
                        Container(
                          height: 40,
                          width: 3,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.black // Active indicator color
                                : Colors.transparent, // Hidden if inactive
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
