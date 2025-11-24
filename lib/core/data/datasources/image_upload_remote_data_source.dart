import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ImageUploadRemoteDataSource {
  Future<String> uploadImage(File file, String bucket, String folder);
}

class ImageUploadRemoteDataSourceImpl implements ImageUploadRemoteDataSource {
  final SupabaseClient supabaseClient;

  ImageUploadRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<String> uploadImage(File file, String bucket, String folder) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final filePath = '$folder/$fileName';

    await supabaseClient.storage
        .from(bucket)
        .upload(
          filePath,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    final publicUrl = supabaseClient.storage
        .from(bucket)
        .getPublicUrl(filePath);
    return publicUrl;
  }
}
