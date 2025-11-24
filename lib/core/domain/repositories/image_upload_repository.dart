import 'dart:io';

abstract class ImageUploadRepository {
  Future<String> uploadPostImage(File file);
  Future<List<String>> uploadPostImages(List<File> files);
}
