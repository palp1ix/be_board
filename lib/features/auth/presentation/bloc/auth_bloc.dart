import 'dart:io';
import 'package:be_board/features/auth/domain/usecases/usecases.dart';
import 'package:be_board/core/core.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final SignOutUseCase _signOutUseCase;
  final ImagePicker _imagePicker;

  AuthBloc(
    this._signUpUseCase,
    this._loginUseCase,
    this._signOutUseCase,
    this._imagePicker,
  ) : super(AuthInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignOutButtonPressed>(_onSignOutButtonPressed);
    on<PickImageButtonPressed>(_onPickImageButtonPressed);
  }

  void _onSignUpButtonPressed(
    SignUpButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _signUpUseCase(
        event.email,
        event.password,
        event.name,
        event.avatar,
      );
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure('Sign up failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure('Login failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onSignOutButtonPressed(
    SignOutButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _signOutUseCase();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onPickImageButtonPressed(
    PickImageButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(ImagePickedSuccess(File(pickedFile.path)));
      } else {
        emit(const ImagePickedFailure('No image selected.'));
      }
    } catch (e) {
      emit(ImagePickedFailure(e.toString()));
    }
  }
}
