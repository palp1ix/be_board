import 'package:be_board/core/core.dart';
import 'package:be_board/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:be_board/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:be_board/features/auth/domain/repositories/auth_repository.dart';
import 'package:be_board/features/auth/domain/usecases/login_use_case.dart';
import 'package:be_board/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:be_board/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:be_board/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:be_board/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:be_board/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:be_board/features/profile/domain/repositories/profile_repository.dart';
import 'package:be_board/features/profile/domain/usecases/get_profile.dart';
import 'package:be_board/core/data/datasources/categories_remote_data_source.dart';
import 'package:be_board/core/data/datasources/posts_remote_data_source.dart';
import 'package:be_board/core/data/repositories/categories_repository_impl.dart';
import 'package:be_board/core/data/repositories/posts_repository_impl.dart';
import 'package:be_board/core/domain/repositories/categories_repository.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:be_board/core/data/datasources/image_upload_remote_data_source.dart';
import 'package:be_board/core/data/repositories/image_upload_repository_impl.dart';
import 'package:be_board/core/domain/repositories/image_upload_repository.dart';
import 'package:be_board/core/domain/usecases/upload_post_images_use_case.dart';
import 'package:be_board/core/services/image_picker_service.dart';
import 'package:be_board/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:be_board/features/favorites/domain/usecases/get_favorite_posts_use_case.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> setupProjectDependencies() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_PROJECT_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Supabase
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Navigation
  sl.registerLazySingleton<AppNavigator>(() => GoRouterNavigator());

  // Image Picker for Auth
  sl.registerLazySingleton(() => ImagePicker());

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerFactory(() => ProfileBloc(getProfile: sl(), signOutUseCase: sl()));

  // Categories
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(sl()),
  );

  // Posts
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(sl()));

  // Image Picker
  sl.registerLazySingleton<ImagePickerService>(() => ImagePickerServiceImpl());

  // Image Upload
  sl.registerLazySingleton<ImageUploadRemoteDataSource>(
    () => ImageUploadRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ImageUploadRepository>(
    () => ImageUploadRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => UploadPostImagesUseCase(sl()));

  // Favorites
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritePostsUseCase(sl()));
}
