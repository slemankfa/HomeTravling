import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/pages/main_cities_pages.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';

import '../../../../styels.dart';

class CountriesItem extends StatelessWidget {
  const CountriesItem({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final LoadedState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MainCitiesPages(
                        country: state.loadedCountriesList[index],
                      )),
            );
          },
          child: Container(
            height: 200,
            // width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    state.loadedCountriesList[index].countryFlag,
                    fit: BoxFit.fill,
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.50,
                    // width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: context.deviceLocale != "ar"
                            ? state
                                .loadedCountriesList[index].countryEnglishName
                            : state
                                .loadedCountriesList[index].countryArabicName,
                        style:
                            Styles.mainTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
