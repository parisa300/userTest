import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUseCase loginUseCase;

  UserBloc(this.loginUseCase) : super(UserInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (user) => emit(UserLoaded(user)),
    );
  }
}
