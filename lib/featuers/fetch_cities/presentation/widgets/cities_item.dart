import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/core/utils/localiztion_helper.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/get_activites/presentation/pages/main_activites_pages.dart';

class CitiesItem extends StatelessWidget {
  CitiesItem({
    Key? key,
    required this.state,
    required this.index,
    required this.countryEntity,
  }) : super(key: key);

  final LoadedState state;
  final int index;
  final CountryEntity countryEntity;
  LocaliztionHelper localiztionHelper = LocaliztionHelper();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MainActivitesPages(
                    city: state.loadedCitiesList[index],
                    countryEntity: countryEntity,
                  )),
        );
      },
      child: Container(
        color: Colors.white,
        // height: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // color: Colors.black26,
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  state.loadedCitiesList[index].cityImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomText(
                text: localiztionHelper.checkLanguage(context) == "ar"
                    ? state.loadedCitiesList[index].cityArabicName
                    : state.loadedCitiesList[index].cityEnaglishName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
