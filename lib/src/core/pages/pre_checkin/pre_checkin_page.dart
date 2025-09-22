import 'package:flutter/material.dart';
import 'package:lab_clinicas_adm/src/shared/data_item.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class PreCheckinPage extends StatelessWidget {
  const PreCheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
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
                    'Cidinei Inacio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                DataItem(
                  label: 'Nome Paciente',
                  value: 'Cidinei Inacio',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Email',
                  value: '99999999',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'CPF',
                  value: '000000000',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'CEP',
                  value: '000000000',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Endereço',
                  value: '000000000 rua',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Responsável',
                  value: '000000000 xxx xxx',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                DataItem(
                  label: 'Documento de identificação',
                  value: '00000000000',
                  padding: EdgeInsets.only(bottom: 24),
                ),
                SizedBox(height: 32,),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(onPressed: () {}, child: Text('Chamar outra senha')))),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(onPressed: () {}, child: Text('Atender')))),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
