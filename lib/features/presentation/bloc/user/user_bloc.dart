import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final LoginUseCase loginUseCase;
//
//   UserBloc(this.loginUseCase) : super(UserInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//   }
//
//   Future<void> _onLoginRequested(LoginRequested event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     final result = await loginUseCase(event.email, event.password);
//     result.fold(
//           (failure) => emit(UserError(failure.message)),
//           (user) => emit(UserLoaded(user)),
//     );
//   }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_) => emit(AuthSuccess()),
    );
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase(event.email, event.password);
    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_) => emit(AuthSuccess()),
    );
  }
}

