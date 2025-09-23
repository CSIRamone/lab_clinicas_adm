import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/bindings/lab_clinicas_application_binding.dart';
import 'package:lab_clinicas_adm/src/core/pages/checkin/checkin_router.dart';
import 'package:lab_clinicas_adm/src/core/pages/home/home_router.dart';
import 'package:lab_clinicas_adm/src/core/pages/login/login_router.dart';
import 'package:lab_clinicas_adm/src/core/pages/pre_checkin/pre_checkin_router.dart';
import 'package:lab_clinicas_adm/src/core/pages/splash/splash_page.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const LabClinicasAdm());
    },
    (error, stack) {
      // ignore: avoid_print
      log('Erro não capturado:', error: error, stackTrace: stack);
      // ignore: avoid_print
      throw error;
    },
  );
}

class LabClinicasAdm extends StatelessWidget {
  const LabClinicasAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab CLinicas Adm',
      bindings: LabClinicasApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashPage(), 
          path: '/',
          ),
      ],
      pages: const [LoginRouter(), HomeRouter(), PreCheckinRouter(), CheckinRouter()],
      );
  }
}
