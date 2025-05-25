import 'package:flutter/material.dart';

class SpottoHomeScreen extends StatelessWidget {
  const SpottoHomeScreen({Key? key}) : super(key: key);

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
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const Text(
                      'Spotto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Spots',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 140,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildSpotCard('Toyota 86', 'Yesterday, 2:30 PM'),
                            const SizedBox(width: 12),
                            _buildSpotCard('Porsche 911', 'Yesterday, 6:30 PM'),
                            const SizedBox(width: 12),
                            _buildSpotCard('BMW 3', 'Yesterday, 7:20PM'),
                            const SizedBox(width: 12),
                            _buildSpotCard('Scroll Test', 'Yesterday, 7:20PM'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Community Highlights',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCommunityPost('John D.', 'Castle Hill, 3 Hours ago'),
                      const SizedBox(height: 16),
                      _buildCommunityPost('Jane D.', 'Cherrybrook, 8 Hours ago'),
                      const SizedBox(height: 32),
                      const Text(
                        'Nearby Activity',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 80,
                              child: _buildMapDot(),
                            ),
                            Positioned(
                              top: 50,
                              right: 100,
                              child: _buildMapDot(),
                            ),
                            Positioned(
                              bottom: 50,
                              left: 140,
                              child: _buildMapDot(),
                            ),
                            Positioned(
                              bottom: 30,
                              right: 150,
                              child: _buildMapDot(),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Text(
                                  '4 Nearby',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
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
                  _buildNavItem(Icons.home, 'Home', true),
                  _buildNavItem(Icons.map, 'Map', false),
                    Transform.translate(
                      offset: const Offset(6, 0.0), 
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[500],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  _buildNavItem(Icons.menu, 'Collections', false),
                  _buildNavItem(Icons.person, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpotCard(String carName, String time) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image,
              size: 40,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            carName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityPost(String name, String location) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.image,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 50,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapDot() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.blue[600],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
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
    );
  }
}
