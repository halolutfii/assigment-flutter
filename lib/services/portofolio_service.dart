import 'dart:io';
import 'package:dio/dio.dart';
import '../models/portofolio.dart';
import 'api_service.dart';

class PortofolioService {
  final ApiService _apiService = ApiService();

  Future<String> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    });

    final response = await _apiService.dio.post(
      '/portofolio/imageportofolio-upload',
      data: formData,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );

    // Backend biasanya balikin URL image di response.data['url']
    return response.data['url'];
  }

  Future<void> createPortofolio(Portofolio portofolio) async {
    final response = await _apiService.dio.post('/portofolio', data: {
      'title': portofolio.title,
      'description': portofolio.description,
      'category': portofolio.category,
      'project_link': portofolio.projectLink,
      'image': portofolio.image,
    });

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create portfolio');
    }
  }

  Future<List<Portofolio>> fetchPortofolios() async {
    final response = await _apiService.dio.get('/portofolio');
    return (response.data as List)
        .map((json) => Portofolio.fromMap(json))
        .toList();
  }

  Future<void> deletePortofolio(String id) async {
    await _apiService.dio.delete('/portofolio/$id');
  }
}