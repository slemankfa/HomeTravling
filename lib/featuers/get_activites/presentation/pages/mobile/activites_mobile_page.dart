import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';

class ActivitiesMobilePage extends StatelessWidget {
  final LoadedState state;
  final CityEntity cityEntity;

  ActivitiesMobilePage({required this.state, required this.cityEntity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: state.loadedActivites.isEmpty
          ? Container(
              child: Center(
                child: CustomText(
                  text: "empty_list".tr(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : FlutterLogo(),
    );
  }
}
