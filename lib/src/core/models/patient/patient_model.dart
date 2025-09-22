import 'package:json_annotation/json_annotation.dart';
import 'package:lab_clinicas_adm/src/core/models/patient/patient_address_model.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel {
  PatientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNamber,
    required this.document,
    required this.address,
    required this.guardian,
    required this.guardianIdentificationNumber,
  });

  String id;
  String name;
  String email;
  @JsonKey(name: 'phone_number')
  String phoneNamber;
  String document;
  final PatientAddressModel address;
  @JsonKey(defaultValue: '')
  String guardian;
  @JsonKey(name: 'guardian_identification_number', defaultValue: '')
  String guardianIdentificationNumber;

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
