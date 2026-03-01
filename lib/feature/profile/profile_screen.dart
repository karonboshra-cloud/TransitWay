import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileMenuItem> menuItems = [
    ProfileMenuItem(
      icon: Icons.point_of_sale,
      title: 'Charge My Points',
      route: '/chargePoints',
      iconColor: const Color(0xFF054F3A),
      titleColor: Colors.black87,
    ),
    ProfileMenuItem(
      icon: Icons.confirmation_number,
      title: 'View My Tickets',
      route: '/tickets',
      iconColor: Colors.blue,
      titleColor: Colors.black87,
    ),
    ProfileMenuItem(
      icon: Icons.help,
      title: 'Helps & Feedback',
      route: '/help',
      iconColor: Colors.orange,
      titleColor: Colors.black87,
    ),
    ProfileMenuItem(
      icon: Icons.logout,
      title: 'Log Out',
      route: '/logout',
      isLogout: true,
      iconColor: Colors.red,
      titleColor: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F9),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 20),
                    _buildProfileHeader(),
                    const SizedBox(height: 40),
                    ..._buildMenuItems(context),
                  ],
                ),
              ),
              _buildBottomNavBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            width: 104,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFCDDFDA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '★',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 24,
                    height: -0.2,
                  ),
                ),
                const SizedBox(width: 4),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF054F3A), Color(0xFF054F3A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    '9833',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1e293b), width: 2),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color(0xFFF2F5FA),
              backgroundImage: const AssetImage('assets/logo/3.png'),
              onBackgroundImageError: (_, __) {},
              child: null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jumana Shahien',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    return menuItems.map((item) {
      final iconColor = item.iconColor ?? const Color(0xFF1e293b);
      final titleColor = item.titleColor ?? Colors.black87;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: item.isLogout ? Colors.red.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isLogout ? Colors.red.shade100 : Colors.grey.shade200,
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: iconColor, size: 22),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          trailing: Icon(
            item.isLogout ? Icons.logout : Icons.arrow_forward_ios,
            size: 16,
            color: iconColor,
          ),
          onTap: () => _handleMenuItemTap(context, item),
        ),
      );
    }).toList();
  }

  void _handleMenuItemTap(BuildContext context, ProfileMenuItem item) {
    if (item.isLogout) {
      _showLogoutDialog(context);
    } else {
      Navigator.pushNamed(context, item.route);
    }
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF1e293b) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF1e293b) : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF1e293b),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String route;
  final bool isLogout;
  final Color? iconColor;
  final Color? titleColor;

  ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.route,
    this.isLogout = false,
    this.iconColor,
    this.titleColor,
  });
}
