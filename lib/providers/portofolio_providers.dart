import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/portofolio.dart';

class PortofolioProvider with ChangeNotifier {
  final List<PortofolioItem> _items = [];
  List<PortofolioItem> get items => _items;

  void addItem(PortofolioItem item) {
    _items.add(item);
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final linkController = TextEditingController();

  String? selectedCategory; 
  DateTime? selectedDate;
  File? selectedImage;

  // Setter Category
  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white, 
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E3A59), 
              onPrimary: Colors.white,  
              onSurface: Colors.black, 
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate = DateTime(picked.year, picked.month);
      dateController.text =
          "${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      notifyListeners();
    }
  }

  // Pick Image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // create porto
  void saveForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final newItem = PortofolioItem(
        title: titleController.text,
        category: selectedCategory ?? "",
        completion: selectedDate, 
        description: descriptionController.text,
        link: linkController.text,
        image: selectedImage!.path,
      );

      addItem(newItem); 

      clearForm();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("Portfolio saved successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }


  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    linkController.clear();
    selectedImage = null;
    selectedCategory = null; 
    selectedDate = null;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    linkController.dispose();
    super.dispose();
  }
}

