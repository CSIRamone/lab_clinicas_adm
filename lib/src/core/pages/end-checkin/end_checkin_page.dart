import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/core/pages/end-checkin/end_checkin_controller.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_core.dart';

class EndCheckinPage extends StatefulWidget {

  const EndCheckinPage({ super.key });

  @override
  State<EndCheckinPage> createState() => _EndCheckinPageState();
}

class _EndCheckinPageState extends State<EndCheckinPage> with MessagesViewMixin{
  final controller = Injector.get<EndCheckinController>();
  
  @override
  void initState() {
    messagesListener(controller);

    effect(() {
      if(controller.informationForm() != null){
          WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/pre-checkin', arguments: controller.informationForm());
      });
      }
    });
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 56),
          padding: EdgeInsets.all(20),
          width: sizeOf.width * 0.45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LabClinicasTheme.orangeColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/check_icon.png'),
              const SizedBox(height: 32),
              Text('Atendimento finalizado com sucesso', style: LabClinicasTheme.titleSmallStyle),
              const SizedBox(height: 32),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.callNextPatient();
                    },
                  child: Text('Chamar outro senha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}