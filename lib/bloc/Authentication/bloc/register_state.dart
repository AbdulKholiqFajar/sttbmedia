part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String? messageSuccess;

  const RegisterSuccess({required this.messageSuccess});
}

class RegisterFailed extends RegisterState {
  final String? messageErrpr;

  const RegisterFailed({required this.messageErrpr});
}
