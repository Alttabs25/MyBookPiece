import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml for date formatting

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for the input fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // Function to show the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Improved Save function with Loading Indicator
  Future<void> _saveBook() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await FirebaseFirestore.instance.collection('books').add({
          'bookId': _idController.text.trim(),
          'bookName': _nameController.text.trim(),
          'author': _authorController.text.trim(),
          'publisher': _publisherController.text.trim(),
          'datePublished': _dateController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });
        
        Navigator.pop(context); // Close loading dialog
        Navigator.pop(context); // Go back to menu
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('📚 Book added successfully!'), backgroundColor: Colors.green),
        );
      } catch (e) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Collection', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Book Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              
              _buildInput(controller: _idController, label: "Book ID", icon: Icons.qr_code),
              _buildInput(controller: _nameController, label: "Book Name", icon: Icons.book_outlined),
              _buildInput(controller: _authorController, label: "Author", icon: Icons.person_outline),
              _buildInput(controller: _publisherController, label: "Publisher", icon: Icons.business_outlined),
              
              // Date Input with Tap Action
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: "Date Published",
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (v) => v!.isEmpty ? 'Please select a date' : null,
              ),

              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _saveBook,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                ),
                child: const Text('Save Record', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Input Widget for cleaner code
  Widget _buildInput({required TextEditingController controller, required String label, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.blue.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
        validator: (v) => v!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}