part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ProsesRegister extends RegisterEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final String tglLahir;

  const ProsesRegister({required this.name, required this.username, required this.email, required this.password, required this.tglLahir});
  @override
  List<Object> get props => [name, username, email, password, tglLahir];

}
