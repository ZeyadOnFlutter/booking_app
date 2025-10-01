import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

extension UserMapper on UserModel {
  UserEntity get toEntity => UserEntity(id: id, name: name, email: email, phone: phone);
}
