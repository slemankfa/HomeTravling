import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/core/utils/localiztion_helper.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';
import 'package:home_travling/featuers/get_activites/presentation/widgets/activites_item.dart';
import 'package:home_travling/styels.dart';

class ActivitiesMobilePage extends StatelessWidget {
  final LoadedState state;
  final CityEntity cityEntity;
  final CountryEntity countryEntity;

  LocaliztionHelper localiztionHelper = LocaliztionHelper();

  ActivitiesMobilePage(
      {required this.state,
      required this.countryEntity,
      required this.cityEntity});

  String _handleAddress(BuildContext context) {
    if (localiztionHelper.checkLanguage(context) == "ar") {
      return "${countryEntity.countryArabicName} - ${cityEntity.cityArabicName}";
    } else {
      return "${countryEntity.countryEnglishName} - ${cityEntity.cityEnaglishName}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: _handleAddress(context),
          style: Styles.appbarTextStyle,
        ),
      ),
      body: state.loadedActivites.isEmpty
          ? Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: CustomText(
                  text: "empty_list".tr(),
                  style: Styles.mainTextStyle.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(16),
              child: ListView.separated(
                  itemBuilder: (context, index) => ActivitesItem(
                      state: state,
                      index: index,
                      localiztionHelper: localiztionHelper),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: state.loadedActivites.length),
            ),
    );
  }
}
