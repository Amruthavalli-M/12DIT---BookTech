import 'package:booktech_flutter/models/model.dart';
import 'package:booktech_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideDrawerMenu extends StatefulWidget {
  final Function(int)? onItemSelected;

  const SideDrawerMenu({super.key, this.onItemSelected});

  @override
  State<SideDrawerMenu> createState() => _SideDrawerMenuState();
}

class _SideDrawerMenuState extends State<SideDrawerMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(color: MyAppColor.secondaryBg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  width: 25,
                  child: SvgPicture.asset(""), // Your logo path
                ),
              ),
              ...List.generate(menuIcons.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    if (widget.onItemSelected != null) {
                      widget.onItemSelected!(index);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        // Center the icon in available space
                        Expanded(
                          child: Center(
                            child: SvgPicture.asset(
                              menuIcons[index],
                              color: selectedIndex == index
                                  ? Colors.black
                                  : MyAppColor.iconGray,
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        // Right slider bar (rounded)
                        Container(
                          height: 40,
                          width: 4,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.transparent,
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
