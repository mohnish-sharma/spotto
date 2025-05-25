import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../navbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  int _totalSpots = 0;
  List<Map<String, dynamic>> _recentCars = [];

  String get username {
    if (currentUser?.email != null) {
      final email = currentUser!.email!;
      if (email.contains('@gmail.com')) {
        return email.split('@gmail.com')[0];
      }
      return email.split('@')[0];
    }
    return 'User';
  }

  @override
  void initState() {
    super.initState();
    _fetchTotalSpots();
  }

  Future<void> _fetchTotalSpots() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('cars').get();
      setState(() {
        _totalSpots = snapshot.docs.length;
        _recentCars = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String _formatTimestampShort(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) {
      return 'Unknown time';
    }
    
    final DateTime dateTime = timestamp.toDate();
    final DateTime now = DateTime.now();
    
    if (DateFormat('yyyy-MM-dd').format(now) == DateFormat('yyyy-MM-dd').format(dateTime)) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('E h:mm a').format(dateTime); 
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }

  Widget _buildCarListItem(Map<String, dynamic> car) {
    final timestamp = car['timestamp'];
    final formattedTime = _formatTimestampShort(timestamp);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: car['imageUrl'] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    car['imageUrl'],
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                )
              : const Icon(Icons.image, color: Colors.black54),
        ),
        title: Text(
          car['name'] ?? 'Unnamed',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: formattedTime.isNotEmpty
            ? Text(
                'Added $formattedTime',
                style: TextStyle(color: Colors.grey[600]),
              )
            : const Text('Tap to view details'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _buildCarGridItem(Map<String, dynamic> car) {
    final timestamp = car['timestamp'];
    final formattedTime = _formatTimestampShort(timestamp);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: car['imageUrl'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      car['imageUrl'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  )
                : const Center(child: Icon(Icons.image, size: 40, color: Colors.black54)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          car['name'] ?? 'Unnamed',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (formattedTime.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[500],
              ),
              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentUser?.email ?? 'email@example.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem('$_totalSpots', 'Total Spots'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildSectionHeader('Your Spots'),
                      const SizedBox(height: 16),
                      if (_recentCars.isEmpty)
                        const Text('No cars found.')
                      else
                        Column(
                          children: _recentCars.reversed.take(5).map((car) {
                            return _buildCarListItem(car);
                          }).toList(),
                        ),
                      
                      const SizedBox(height: 32),
                      _buildSectionHeader('Account'),
                      const SizedBox(height: 16),
                      _buildActionItem('Sign Out', Icons.logout, () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          if (mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/',
                              (Route<dynamic> route) => false,
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error signing out: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }, isDestructive: true),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            const CustomBottomNavBar(currentIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red[600] : Colors.grey[700],
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDestructive ? Colors.red[600] : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}