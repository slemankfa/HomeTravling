import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

class CitiesWebPage extends StatelessWidget {
  final LoadedState state;
  final CountryEntity countryEntity;

  const CitiesWebPage({required this.state, required this.countryEntity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CustomText(
            text: "Web",
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}
