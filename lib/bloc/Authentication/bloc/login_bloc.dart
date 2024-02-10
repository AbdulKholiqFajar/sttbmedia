import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_media_apps/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<InitLogin>(_initLogin);
    on<ProsesLogin>(_prosesLogin);
    on<ProsesLogout>(_prosesLogout);
  }

  _initLogin(InitLogin event, Emitter emit) async {
    emit(LoginLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionToken = prefs.getString('session') ?? "";
    print("session $sessionToken");
    if (sessionToken == null) {
      emit(LoginInitial());
    } else {
      var result = await loginRepository.checkSession(sessionToken);
      var json = jsonDecode(result);
      print("Res: $json");
      if (json['status'] == 'success') {
        emit(LoginSuccess(sessionToken: sessionToken));
      } else {
        emit(LoginInitial() );
      }
    }
  }

  _prosesLogout(ProsesLogout event, Emitter emit) async {
    emit(LoginLoading());
    await loginRepository.logout();
    emit(LoginInitial());
  }

  _prosesLogin(ProsesLogin event, Emitter emit) async {
    String username = event.username;
    String password = event.password;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(LoginLoading());
    var res = await loginRepository.login(username: username, password: password);
    print("Result: $res");
    if (res['status'] == true) {
      prefs.setString("session", res['data']['session_token']);
      emit(LoginSuccess(sessionToken: res['data']['session_token']));
    } else {
      emit(LoginFailure(error: 'login failed: ${res['messsage']}'));
    }

    // if (username == '' && password == 'sttb123') {
    //   emit(LoginSuccess(sessionToken: '123456789'));
    // } else {
    //   emit(LoginFailure(error: 'Login failed'));
    // }
  }
}
