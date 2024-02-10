import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_apps/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository? repository;
  RegisterBloc({required this.repository}) : super(RegisterInitial()) {
    on<ProsesRegister>(register);
  }

  void register(ProsesRegister event, Emitter emit) async {
    String? name = event.name;
    String? username = event.username;
    String? email = event.email;
    String? password = event.password;
    String? tglLahir = event.tglLahir;
    var response = await repository!.register(name: name, username: username, email: email, password: password, tglLahir: tglLahir);
    print('Register : $response');
    emit(RegisterLoading());
    if (response['status'] == 'success') {
      emit(RegisterSuccess(messageSuccess: response['message']));
    } else {
      emit(RegisterFailed(messageErrpr: response['message']));
    }
  }
}
