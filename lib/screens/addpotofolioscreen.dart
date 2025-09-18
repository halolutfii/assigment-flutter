import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portofolio_providers.dart';
import 'dart:io';

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({super.key});

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  bool isLoading = false;
  String? imageError;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortofolioProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Portfolio",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: provider.titleController,
                decoration: const InputDecoration(labelText: 'Project Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),

              const SizedBox(height: 12),

              // Category
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                dropdownColor: Colors.white,
                value: provider.selectedCategory,
                items: ['Website App', 'Mobile App']
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    provider.setCategory(value);
                  }
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),

              const SizedBox(height: 12),

              // Description
              TextFormField(
                controller: provider.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Description is required' : null,
              ),

              const SizedBox(height: 12),

              // Date
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: provider.dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Completion Date (MM/YYYY)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Completion date required';
                        }
                        if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$').hasMatch(value)) {
                          return 'Enter valid date (MM/YYYY)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => provider.pickDate(context),
                    child: const Text(
                      'Pick Date',
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Link
              TextFormField(
                controller: provider.linkController,
                decoration:
                    const InputDecoration(labelText: 'Project Link (optional)'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final urlPattern = r'^(http|https):\/\/([\w.]+\/?)\S*';
                    if (!RegExp(urlPattern).hasMatch(value)) {
                      return 'Enter valid URL';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Image Picker
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.selectedImage != null)
                    Image.file(
                      provider.selectedImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  if (imageError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        imageError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      await provider.pickImage();
                      setState(() {
                        imageError = null;
                      });
                    },
                    child: const Text(
                      'Pick Image',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final userId = 'user-id-xxx'; 
                              setState(() {
                                isLoading = true;
                              });

                              await provider.saveForm(context, userId);

                              setState(() {
                                isLoading = false;
                              });
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Submit'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor: Colors.white,
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF2E3A59),
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                              content: const Text(
                                "Are you sure you want to cancel?",
                                style: TextStyle(color: Colors.black87),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Color(0xFF2E3A59)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    provider.clearForm();
                                    Navigator.pop(ctx);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(color: Color(0xFF2E3A59)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}