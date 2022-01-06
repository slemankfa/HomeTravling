import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName, userPassword, userImage, userId, userEmail, userToken;

  UserEntity(
      {required this.userName,
      required this.userPassword,
      required this.userImage,
      required this.userToken,
      required this.userId,
      required this.userEmail});

  @override
  // TODO: implement props
  List<Object?> get props => [
        userEmail,
        userId,
        userImage,
        userName,
        userToken,
        userPassword,
      ];
}
