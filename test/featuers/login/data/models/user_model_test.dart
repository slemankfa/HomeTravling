import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/login/data/models/user_model.dart';
import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';

import '../../../../fixtuers/fixtuers_readers.dart';

void main() async {
  UserModel tUserModel = UserModel(
      userId: "1",
      userName: "sleman",
      userImage: "image",
      userPassword: "",
      userEmail: "test@gmail.com",
      userToken: "1");
  test("should be a subclass from UserEntity", () {
    // assert
    expect(tUserModel, isA<UserEntity>());
  });

/* 
in case you want to use your server too
 */
  group("From json", () {
    test("should return a valid model from the JSON", () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixtuer("user.json"));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, tUserModel);
    });
  });

  group("toJson", () {
    test("should return a Json map", () {
      // act
      final expeactedMap = {
        "user_id": "1",
        "user_name": "sleman",
        "user_image": "image",
        "user_email": "test@gmail.com",
        "user_token": "1"
      };

      final result = tUserModel.toJson();

      // assert
      expect(result, expeactedMap);
    });
  });
}
