import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_adm/src/core/models/patient/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/core/pages/checkin/checkin_controller.dart';
import 'package:lab_clinicas_adm/src/core/pages/checkin/widget/checkin_image_link.dart';
import 'package:lab_clinicas_adm/src/shared/data_item.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessagesViewMixin {
  final controller = Injector.get<CheckinController>();

  @override
  void initState() {
    messagesListener(controller);
    effect((){
      if(controller.endProcess()){
        Navigator.of(context).pushReplacementNamed('/end-checkin');
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    final PatientInformationFormModel(
      :password,
      :patient,
      :medicalOrders,
      :healthInsuranceCard,
    ) = controller.informationForm.watch(
      context,
    )!;
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: sizeOf.width * 0.50,
            padding: EdgeInsets.all(40),
            margin: EdgeInsets.only(top: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/patient_avatar.png'),
                SizedBox(height: 16),
                const Text(
                  'A senha chamada foi',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  width: 218,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    password,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.ligthOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Cadastro',
                    style: LabClinicasTheme.titleSmallStyle.copyWith(
                      color: LabClinicasTheme.orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                DataItem(
                  label: 'Nome Paciente',
                  value: patient.name,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Email',
                  value: patient.email,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'CPF',
                  value: patient.document,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'CEP',
                  value: patient.address.cep,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Endereço',
                  value:
                      '${patient.address.streetAddress}, ${patient.address.number}, ${patient.address.addressComplement}, ${patient.address.district}, ${patient.address.city} - ${patient.address.state}',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Responsável',
                  value: patient.guardian,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Documento de identificação',
                  value: patient.guardianIdentificationNumber,
                  padding: EdgeInsets.only(bottom: 24),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.ligthOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Validar Imagens Exames',
                    style: LabClinicasTheme.titleSmallStyle.copyWith(
                      color: LabClinicasTheme.orangeColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                      label: 'Carteirinha',
                      image: healthInsuranceCard,
                    ),
                    Column(
                      children: [
                        for (final (index, medicalOrder)
                            in medicalOrders.indexed)
                          CheckinImageLink(
                            label: 'Pedido Médico ${index +1}',
                            image: medicalOrder,
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),

                SizedBox(
                  width: sizeOf.width * 0.70,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.endCheckin();
                    },
                    child: Text('Finalizar Atendimento'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
