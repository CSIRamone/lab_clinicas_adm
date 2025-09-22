import 'dart:developer';

import 'package:lab_clinicas_adm/src/core/models/patient/patient_information_form_model.dart';
import 'package:lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/painel/painel_repository.dart';
import 'package:lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class CallNextPatientService {
  CallNextPatientService({
    required PatientInformationFormRepository patientInformationFormRepository,
    required AttendantDeskAssignmentRepository
    attendantDeskAssignmentRepository,
    required PainelRepository painelRepository,
  }) : _patientInformationFormRepository = patientInformationFormRepository,
       _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
       _painelRepository = painelRepository;

  final PatientInformationFormRepository _patientInformationFormRepository;
  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final PainelRepository _painelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>>
  execute() async {
    final result = await _patientInformationFormRepository.callNextToCheckin();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>>
  updatePanel(PatientInformationFormModel form) async {
    final resultDesk = await _attendantDeskAssignmentRepository
        .getDeskAssignement();
    switch (resultDesk) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final resultPanel = await _painelRepository.callOnPanel(
          form.password,
          deskNumber,
        );
        switch (resultPanel) {
          case Left(value: final exception):
            log(
              'Atenção Não foi possivel chamar o paciente no painel',
              error: exception,
              stackTrace: StackTrace.fromString(
                'Atenção Não foi possivel chamar o paciente no painel',
              ),
            );
            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
