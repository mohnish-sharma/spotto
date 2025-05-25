import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}


// PLACEHOLDER LIST FOR TO TEST UI BEFORE SETTING UP FIRESTORE
class _CollectionsScreenState extends State<CollectionsScreen> {
  String _selectedView = 'Grid';
  final TextEditingController _searchController = TextEditingController();
  
  final List<Map<String, String>> _cars = [
    {'name': 'Porsche 911', 'image': ''},
    {'name': 'BMW M4', 'image': ''},
    {'name': 'Audi R8', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
    {'name': 'Car Name', 'image': ''},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue[500],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'My Collection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        _buildViewOption('Grid'),
                        _buildViewOption('List'),
                        _buildViewOption('Map'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
            // Bottom Navigation Bar
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
                  _buildNavItem(Icons.home, 'Home', false, context),
                  _buildNavItem(Icons.map, 'Map', false, context),
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
                  _buildNavItem(Icons.menu, 'Collections', true, context), // Active state
                  _buildNavItem(Icons.person, 'Profile', false, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewOption(String option) {
    final isSelected = _selectedView == option;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedView = option;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[500] : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedView) {
      case 'Grid':
        return _buildGridView();
      case 'List':
        return _buildListView();
      case 'Map':
        return _buildMapView();
      default:
        return _buildGridView();
    }
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: _cars.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _cars[index]['name']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _cars.length,
      itemBuilder: (context, index) {
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
              child: const Icon(
                Icons.image,
                color: Colors.black54,
              ),
            ),
            title: Text(
              _cars[index]['name']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('Tap to view details'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

  Widget _buildMapView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Navigation bar item builder
  Widget _buildNavItem(IconData icon, String label, bool isActive, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pop(context); 
        }
      },
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
}