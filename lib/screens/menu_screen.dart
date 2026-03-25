import 'package:flutter/material.dart';
import 'add_book_screen.dart';
import 'retrieve_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack to put a gradient behind everything
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Colors.white],
                stops: [0.0, 0.3, 0.8],
              ),
            ),
          ),
          
          // 2. Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  // Header Section
                  const Icon(Icons.library_books_rounded, size: 60, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome back,",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const Text(
                    "MyBookPiece",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  // Menu Buttons Section
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 20),
                  
                  _buildMenuCard(
                    context,
                    title: "Add New Book",
                    subtitle: "Register a new book to the cloud",
                    icon: Icons.add_rounded,
                    color: Colors.blueAccent,
                    destination: const AddBookScreen(),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  _buildMenuCard(
                    context,
                    title: "View Records",
                    subtitle: "Browse and manage your library",
                    icon: Icons.auto_stories_rounded,
                    color: Colors.green.shade600,
                    destination: const RetrieveScreen(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A custom "Card Tile" for the menu items
  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}