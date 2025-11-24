import 'dart:io';
import 'package:be_board/core/core.dart';
import 'package:be_board/core/domain/entities/category.dart';
import 'package:be_board/core/domain/repositories/categories_repository.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/core/domain/usecases/upload_post_images_use_case.dart';
import 'package:be_board/core/services/image_picker_service.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CategoriesRepository _categoriesRepository;
  final PostsRepository _postsRepository;
  final ImagePickerService _imagePickerService;
  final UploadPostImagesUseCase _uploadPostImagesUseCase;

  CreatePostCubit({
    required CategoriesRepository categoriesRepository,
    required PostsRepository postsRepository,
    required ImagePickerService imagePickerService,
    required UploadPostImagesUseCase uploadPostImagesUseCase,
  }) : _categoriesRepository = categoriesRepository,
       _postsRepository = postsRepository,
       _imagePickerService = imagePickerService,
       _uploadPostImagesUseCase = uploadPostImagesUseCase,
       super(
         const CreatePostState(
           progress: 0.25,
           selectedPhotos: [],
           uploadedPhotoUrls: [],
           selectedCategory: null,
           categories: [],
           isLoading: true,
           title: '',
           price: '',
           description: '',
         ),
       ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    if (isClosed) return;

    try {
      final categories = await _categoriesRepository.getCategories();
      if (isClosed) return;
      emit(state.copyWith(categories: categories, isLoading: false));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(isLoading: false, error: 'Failed to load categories'),
      );
    }
  }

  Future<void> pickImages() async {
    if (state.selectedPhotos.length >= 10) {
      emit(state.copyWith(error: 'Maximum 10 images allowed'));
      return;
    }

    final images = await _imagePickerService.pickMultipleImages();

    if (images.isEmpty) return;

    final currentPhotos = List<File>.from(state.selectedPhotos);
    final remainingSlots = 10 - currentPhotos.length;
    final photosToAdd = images.take(remainingSlots).toList();

    currentPhotos.addAll(photosToAdd);

    emit(state.copyWith(selectedPhotos: currentPhotos, error: null));
  }

  void removePhoto(int index) {
    final updatedPhotos = List<File>.from(state.selectedPhotos)
      ..removeAt(index);
    emit(state.copyWith(selectedPhotos: updatedPhotos));
  }

  void setCategory(String categoryName) {
    final category = state.categories.firstWhere((c) => c.name == categoryName);
    emit(state.copyWith(selectedCategory: category));
  }

  void updateProgress(double progress) {
    emit(state.copyWith(progress: progress.clamp(0.0, 1.0)));
  }

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setPrice(String price) {
    emit(state.copyWith(price: price));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> createPost() async {
    if (state.selectedCategory == null ||
        state.title.isEmpty ||
        state.price.isEmpty) {
      emit(state.copyWith(error: 'Please fill in all required fields'));
      return;
    }

    if (state.selectedPhotos.isEmpty) {
      emit(state.copyWith(error: 'Please add at least one photo'));
      return;
    }

    if (isClosed) return;
    emit(state.copyWith(isLoading: true, isUploading: true, error: null));

    try {
      final uploadedUrls = await _uploadPostImagesUseCase(state.selectedPhotos);

      if (isClosed) return;
      emit(state.copyWith(uploadedPhotoUrls: uploadedUrls, isUploading: false));

      final post = PostItem(
        id: '', // Server will generate the ID
        imageUrl: uploadedUrls.first,
        title: state.title,
        description: state.description,
        price: double.tryParse(state.price) ?? 0,
        location: 'Not specified',
        createdAt: DateTime.now().toIso8601String(),
        category: state.selectedCategory!.name,
        rating: 0,
        gallery: uploadedUrls,
      );

      await _postsRepository.createPost(post);

      if (isClosed) return;
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          isUploading: false,
          error: 'Failed to create post: ${e.toString()}',
        ),
      );
    }
  }
}
