import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/portofolio.dart';

class PortofolioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  // Meng-upload gambar portofolio ke Supabase Storage
  Future<String> uploadImage(File file, String userId) async {
    try {
      final fileName = 'portofolios/$userId/${file.uri.pathSegments.last}';
      // final ref = _supabase.storage.from('portofolios').getReference(fileName);
      // await ref.upload(file);

      final url = _supabase.storage.from('portofolios').getPublicUrl(fileName);
      return url;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Membuat portofolio baru
  Future<void> createPortofolio(Portofolio portofolio) async {
    try {
      await _firestore.collection('portofolios').add({
        'userId': portofolio.userId,
        'title': portofolio.title,
        'description': portofolio.description,
        'category': portofolio.category,
        'project_link': portofolio.projectLink,
        'image': portofolio.image,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to create portofolio: $e');
    }
  }

  // Mengambil portofolio berdasarkan userId
  Future<List<Portofolio>> fetchPortofolios(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('portofolios')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => Portofolio.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch portofolios: $e');
    }
  }

  // Menghapus portofolio berdasarkan id
  Future<void> deletePortofolio(String id) async {
    try {
      await _firestore.collection('portofolios').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete portofolio: $e');
    }
  }
}