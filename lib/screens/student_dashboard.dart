import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      drawer: isMobile ? const DrawerMenu() : null,
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isMobile ? const MobileLayout() : const DesktopLayout(),
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
          const SizedBox(height: 30),
          const Icon(Icons.light_mode, size: 60), // placeholder for logo
          const SizedBox(height: 20),
          menuItem(Icons.home, "Home"),
          menuItem(Icons.event, "All Events"),
          menuItem(Icons.person, "My Profile"),
          menuItem(Icons.notifications, "Notifications"),
          menuItem(Icons.logout, "Signout"),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String label) {
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
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Menu", style: TextStyle(color: Colors.white)),
          ),
          Sidebar().menuItem(Icons.home, "Home"),
          Sidebar().menuItem(Icons.event, "All Events"),
          Sidebar().menuItem(Icons.person, "My Profile"),
          Sidebar().menuItem(Icons.notifications, "Notifications"),
          Sidebar().menuItem(Icons.logout, "Signout"),
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
        Expanded(
          child: dashboardCard("Volunteer"),
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
        dashboardCard("Volunteer"),
      ],
    );
  }
}

Widget dashboardCard(String title) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text("(Content placeholder)")
      ],
    ),
  );
}
