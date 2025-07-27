import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      drawer: isMobile ? const DrawerMenu() : null,
      body: Row(
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(
            child: Column(
              children: [
                // Top bar (title) only for desktop
                if (!isMobile)
                  Container(
                    height: 60,
                    color: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Student Dashboard",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                // AppBar alternative for mobile
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
                    child: isMobile
                        ? const MobileLayout()
                        : const DesktopLayout(),
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
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            height: 60,
            color: Colors.purple,
            alignment: Alignment.center,
            child: const Icon(Icons.light_mode, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 20),
          _menuItem(Icons.home, "Home"),
          _menuItem(Icons.event, "All Events"),
          _menuItem(Icons.person, "My Profile"),
          _menuItem(Icons.notifications, "Notifications"),
          _menuItem(Icons.logout, "Signout"),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {},
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120,
            color: Colors.purple,
            alignment: Alignment.center,
            child: const Icon(Icons.light_mode, size: 50, color: Colors.white),
          ),
          const Sidebar(), // Reuses the sidebar content
        ],
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top half: My Events + Alerts
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: dashboardCard("My Events"),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: dashboardCard("Alerts"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Bottom half: Volunteer full width
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: dashboardCard("Volunteer"),
              ),
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "(Content placeholder)",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
