import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/core/pages/home/home_controller.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin{

  final formKey = GlobalKey<FormState>();
  final deskNumberEC = TextEditingController();
  final controller = Injector.get<HomeController>();

  @override
  void initState() {
   messagesListener(controller);
    super.initState();
  }

  @override
  void dispose() {
   deskNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            width: sizeOf.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Bem Vindo!', style: LabClinicasTheme.titleStyle),
              const SizedBox(height: 32,),
              Text('Preencha o número do guichê que voce está atendendo',
              style: LabClinicasTheme.subtitleStyle,
              ),
              const SizedBox(height: 24,),
              SizedBox(
                width: sizeOf.width * 0.30,
                child: TextFormField(
                  controller: deskNumberEC,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Guichê obrigatório'),
                      Validatorless.number('Guichê deve ser um número'),

                    ]
                  ),
                  decoration: InputDecoration(label: Text('Número do Guichê')),
                ),
              ),
              const SizedBox(height: 32,),
              SizedBox(
                height: 48,
                width: sizeOf.width * 0.30,
                child: ElevatedButton(onPressed: () {
                  final valid = formKey.currentState?.validate() ?? false;
                  if(valid){
                    controller.startService(int.parse(deskNumberEC.text));
                  }
                }, child: Text('Chamar próximo paciente'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
