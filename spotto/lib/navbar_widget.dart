import 'package:flutter/material.dart';
import 'screens/collections_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/spotto_home_screen.dart';
import 'screens/car_creation_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
 
  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, context),
          _buildNavItem(Icons.map, 'Map', 1, context),
          GestureDetector(
            onTap: () => _showCreationScreen(context),
            child: Transform.translate(
              offset: const Offset(6, 0.0),
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          _buildNavItem(Icons.menu, 'Collections', 2, context),
          _buildNavItem(Icons.person, 'Profile', 3, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, BuildContext context) {
    final bool isActive = currentIndex == index;
   
    return GestureDetector(
      onTap: () => _handleNavigation(label, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.black : Colors.grey[400],
            size: 40,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreationScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CarCreationScreen(),
    );
  }

  void _handleNavigation(String label, BuildContext context) {
    switch (label) {
      case 'Home':
        if (currentIndex != 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SpottoHomeScreen()),
            (route) => false,
          );
        }
        break;
      case 'Map':
        break;
      case 'Collections':
        if (currentIndex != 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CollectionsScreen()),
          );
        }
        break;
      case 'Profile':
        if (currentIndex != 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
        break;
    }
  }
}