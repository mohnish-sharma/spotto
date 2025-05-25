import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../navbar_widget.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  String _selectedView = 'Grid';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTimestampShort(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) {
      return '';
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
                  const Center(
                    child: Text(
                      'My Collection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            const CustomBottomNavBar(currentIndex: 2),
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
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cars').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No cars found.'));
          }

          final carDocs = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75, 
            ),
            itemCount: carDocs.length,
            itemBuilder: (context, index) {
              final car = carDocs[index].data() as Map<String, dynamic>;
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
            },
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cars').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No cars found.'));
        }

        final carDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: carDocs.length,
          itemBuilder: (context, index) {
            final car = carDocs[index].data() as Map<String, dynamic>;
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
          },
        );
      },
    );
  }

  Widget _buildMapView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}