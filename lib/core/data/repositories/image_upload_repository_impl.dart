import 'dart:io';
import 'package:be_board/core/data/datasources/image_upload_remote_data_source.dart';
import 'package:be_board/core/domain/repositories/image_upload_repository.dart';

class ImageUploadRepositoryImpl implements ImageUploadRepository {
  final ImageUploadRemoteDataSource remoteDataSource;

  ImageUploadRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> uploadPostImage(File file) async {
    return await remoteDataSource.uploadImage(file, 'images', 'posts');
  }

  @override
  Future<List<String>> uploadPostImages(List<File> files) async {
    final List<String> uploadedUrls = [];

    for (final file in files) {
      final url = await uploadPostImage(file);
      uploadedUrls.add(url);
    }

    return uploadedUrls;
  }
}
