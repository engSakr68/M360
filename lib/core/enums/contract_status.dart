import 'dart:ui';

import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/app_colors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum ContractStatus {
  newCode("37710"),
  canceled('37790'),
  paused('37780'),
  posted('37770'),
  completed('37760'),
  implemented('37750'),
  rejectedByTheOwner('37732'),
  attribution('37731'),
  owner('37730'),
  rejectedByTheSupervisor('37722'),
  supervisorApproved('37721'),
  applicationApproval('37720'),
  supervisorIdentifications('37715'),
  non('0');

  final String value;

  const ContractStatus(this.value);
  factory ContractStatus.fromValue(String val) {
    try {
      return ContractStatus.values.enumFactory(val);
    } catch (_) {}
    return non;
  }

  String getLocalizedName() {
    switch (this) {
      case ContractStatus.applicationApproval:
        return Translate.s.application_approval;
      case ContractStatus.attribution:
        return Translate.s.attribution;
      case ContractStatus.canceled:
        return Translate.s.canceled;
      case ContractStatus.completed:
        return Translate.s.completed;
      case ContractStatus.implemented:
        return Translate.s.implemented;
      case ContractStatus.owner:
        return Translate.s.owner;
      case ContractStatus.paused:
        return Translate.s.paused;
      case ContractStatus.posted:
        return Translate.s.posted;
      case ContractStatus.rejectedByTheOwner:
        return Translate.s.rejected_by_the_owner;
      case ContractStatus.rejectedByTheSupervisor:
        return Translate.s.rejected_by_the_supervisor;
      case ContractStatus.supervisorApproved:
        return Translate.s.supervisor_approved;
      case ContractStatus.supervisorIdentifications:
        return Translate.s.supervisor_identifications;
      case ContractStatus.newCode:
        return Translate.s.new_code;
      default:
        return "";
    }
  }

  Color getColor() {
    switch (this) {
      case ContractStatus.applicationApproval:
        return AppColors.fixedColors.primary;
      case ContractStatus.attribution:
        return AppColors.fixedColors.secondary;
      case ContractStatus.owner:
        return AppColors.fixedColors.primary;
      case ContractStatus.paused:
        return AppColors.fixedColors.secondary;
      case ContractStatus.posted:
        return AppColors.fixedColors.primary;
      case ContractStatus.supervisorIdentifications:
        return AppColors.fixedColors.secondary;
      default:
        return AppColors.fixedColors.primary;
    }
  }
}
