import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:windy/models/enums/user_type.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? email,
    String? password,
    String? fullName,
    String? port,
    String? address,
    @Default(UserType.officer) UserType type,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
