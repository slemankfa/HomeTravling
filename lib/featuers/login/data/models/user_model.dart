import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String userId,
    required String userName,
    required String userImage,
    required String userPassword,
    required String userEmail,
    required String userToken,
  }) : super(
          userEmail: userEmail,
          userId: userId,
          userImage: userImage,
          userName: userName,
          userPassword: userPassword,
          userToken: userToken,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        userId: map["user_id"],
        userName: map["user_name"],
        userImage: map["user_image"],
        userPassword: "",
        userEmail: map["user_email"],
        userToken: map["user_token"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "user_image": userImage,
      "user_email": userEmail,
      "user_token": userToken
    };
  }
}
 