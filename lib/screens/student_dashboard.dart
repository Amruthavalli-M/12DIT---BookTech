import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      drawer: isMobile ? DrawerMenu(isCollapsed: isCollapsed) : null,
      body: Row(
        children: [
          if (!isMobile)
            Sidebar(
              isCollapsed: isCollapsed,
              onToggle: () => setState(() => isCollapsed = !isCollapsed),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile)
                  Container(
                    height: 60,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isCollapsed ? Icons.menu_open : Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () => setState(() => isCollapsed = !isCollapsed),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Student Dashboard",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isMobile)
                  AppBar(
                    title: Row(
                      children: const [
                        Icon(Icons.light_mode),
                        SizedBox(width: 8),
                        Text("Student Dashboard"),
                      ],
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isMobile ? const MobileLayout() : const DesktopLayout(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const Sidebar({super.key, required this.isCollapsed, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.calendar_month, 'label': 'All Events'},
      {'icon': Icons.notifications, 'label': 'Notification'},

    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 70 : 200,
      color: const Color(0xFF1F2430),
      child: Column(
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.center,
              children: [
                Icon(Icons.shop, color: Colors.blue.shade300, size: 30),
                if (!isCollapsed)
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'BookTech',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(color: Colors.white24),
          Expanded(
            child: ListView(
              children: menuItems.map((item) => _menuItem(item['icon'], item['label'], isCollapsed)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, bool collapsed) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(label, style: const TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final bool isCollapsed;
  const DrawerMenu({super.key, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Sidebar(isCollapsed: isCollapsed, onToggle: () {}),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: dashboardCard("My Events")),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: dashboardCard("Alerts")),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              Expanded(child: dashboardCard("Volunteer")),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        dashboardCard("My Events"),
        const SizedBox(height: 16),
        dashboardCard("Alerts"),
        const SizedBox(height: 16),
        dashboardCard("Volunteer"),
      ],
    );
  }
}

Widget dashboardCard(String title) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFF2D3344),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "(Content placeholder)",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}
