import 'dart:io';
import 'package:be_board/core/domain/repositories/image_upload_repository.dart';

class UploadPostImagesUseCase {
  final ImageUploadRepository repository;

  UploadPostImagesUseCase(this.repository);

  Future<List<String>> call(List<File> images) async {
    if (images.isEmpty) {
      throw ArgumentError('No images provided');
    }

    if (images.length > 10) {
      throw ArgumentError('Maximum 10 images allowed');
    }

    return await repository.uploadPostImages(images);
  }
}
