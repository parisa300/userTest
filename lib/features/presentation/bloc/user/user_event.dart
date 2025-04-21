abstract class UserEvent {}

class LoginRequested extends UserEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}
