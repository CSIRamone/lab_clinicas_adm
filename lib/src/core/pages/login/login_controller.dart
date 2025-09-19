import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_adm/src/services/user_login_service.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_core.dart';


class LoginController with MessageStateMixin {
  final UserLoginService _userLoginService;

  LoginController({required UserLoginService userLoginService})
    : _userLoginService = userLoginService;

  final _obscurePassword = signal(true);
  bool get obscurePassword => _obscurePassword();

  void toggleObscurePassword() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  final _logged = signal(false);
  bool get logged => _logged();

  Future<void> login(String email, String password) async {
    final loginResult = await _userLoginService
        .execute(email, password)
        .asyncLoader();

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        //mostrar erro
        showError(message);
      case Right(value: _):
        //navegar para home
        showSuccess('Login realizado com sucesso');
        // ignore: use_build_context_synchronously
        _logged.value = true;
    }
  }
}
