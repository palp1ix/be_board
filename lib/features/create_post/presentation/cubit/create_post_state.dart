part of 'create_post_cubit.dart';

class CreatePostState extends Equatable {
  const CreatePostState({
    required this.progress,
    required this.selectedPhotos,
    required this.uploadedPhotoUrls,
    required this.selectedCategory,
    required this.categories,
    required this.isLoading,
    required this.title,
    required this.price,
    required this.description,
    this.isSuccess = false,
    this.isUploading = false,
    this.uploadProgress,
    this.error,
  });

  final double progress;
  final List<File> selectedPhotos;
  final List<String> uploadedPhotoUrls;
  final Category? selectedCategory;
  final List<Category> categories;
  final bool isLoading;
  final String title;
  final String price;
  final String description;
  final bool isSuccess;
  final bool isUploading;
  final double? uploadProgress;
  final String? error;

  CreatePostState copyWith({
    double? progress,
    List<File>? selectedPhotos,
    List<String>? uploadedPhotoUrls,
    Category? selectedCategory,
    List<Category>? categories,
    bool? isLoading,
    String? title,
    String? price,
    String? description,
    bool? isSuccess,
    bool? isUploading,
    double? uploadProgress,
    String? error,
  }) {
    return CreatePostState(
      progress: progress ?? this.progress,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      uploadedPhotoUrls: uploadedPhotoUrls ?? this.uploadedPhotoUrls,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      isSuccess: isSuccess ?? this.isSuccess,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    progress,
    selectedPhotos,
    uploadedPhotoUrls,
    selectedCategory,
    categories,
    isLoading,
    title,
    price,
    description,
    isSuccess,
    isUploading,
    uploadProgress,
    error,
  ];
}
