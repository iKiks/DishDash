import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/features/login_sign_up/domain/usecases/login_usecase.dart';
import 'package:dishdash/features/login_sign_up/domain/usecases/sign_up_usecase.dart';

enum RequestStatus { initial, loading, success, failure }

class AuthState {
  const AuthState({
    this.loginStatus = RequestStatus.initial,
    this.signUpStatus = RequestStatus.initial,
    this.token,
    this.errorMessage,
  });

  final RequestStatus loginStatus;
  final RequestStatus signUpStatus;
  final String? token;
  final String? errorMessage;

  AuthState copyWith({
    RequestStatus? loginStatus,
    RequestStatus? signUpStatus,
    String? token,
    String? errorMessage,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      token: token ?? this.token,
      errorMessage: errorMessage,
    );
  }
}

abstract class AuthEvent {
  const AuthEvent();
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;
}

class SignUpSubmitted extends AuthEvent {
  const SignUpSubmitted({required this.user, required this.password});

  final User user;
  final String password;
}

class AuthStatusCleared extends AuthEvent {
  const AuthStatusCleared();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
  }) : _loginUseCase = loginUseCase,
       _signUpUseCase = signUpUseCase,
       super(const AuthState()) {
    on<LoginSubmitted>(_handleLoginSubmitted);
    on<SignUpSubmitted>(_handleSignUpSubmitted);
    on<AuthStatusCleared>(_handleStatusCleared);
  }

  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;

  Future<void> _handleLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(loginStatus: RequestStatus.loading, errorMessage: null),
    );

    try {
      final token = await _loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      emit(
        state.copyWith(
          loginStatus: RequestStatus.success,
          token: token,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loginStatus: RequestStatus.failure,
          errorMessage: _mapErrorMessage(error),
        ),
      );
    }
  }

  Future<void> _handleSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(signUpStatus: RequestStatus.loading, errorMessage: null),
    );

    try {
      await _signUpUseCase(
        SignUpParams(user: event.user, password: event.password),
      );

      emit(
        state.copyWith(signUpStatus: RequestStatus.success, errorMessage: null),
      );
    } catch (error) {
      emit(
        state.copyWith(
          signUpStatus: RequestStatus.failure,
          errorMessage: _mapErrorMessage(error),
        ),
      );
    }
  }

  void _handleStatusCleared(AuthStatusCleared event, Emitter<AuthState> emit) {
    emit(const AuthState());
  }

  String _mapErrorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map<String, dynamic>) {
        final message = responseData['message'];
        if (message is String && message.isNotEmpty) {
          return message;
        }
      }
      return error.message ?? 'Something went wrong. Please try again.';
    }

    return error.toString();
  }
}
