import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';

import '../../../../../styels.dart';

class CountriesWebPage extends StatelessWidget {
  const CountriesWebPage({
    Key? key,
    required this.state,
  }) : super(key: key);

  final LoadedState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black26,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .30,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/goldenplacestovisit.appspot.com/o/images%2FCountries%2F%D8%B5%D9%88%D8%B1-%D9%85%D8%B3%D8%A7%D9%81%D8%B1-1.png?alt=media&token=8289c08f-c326-42dd-8a5d-c14b97852192",
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //     top: 0,
              //     left: 0,
              //     bottom: 0,
              //     right: 0,
              //     child: Center(
              //       child: const FlutterLogo(),
              //       // CustomText(
              //       //   text: "main_screen_header_title".tr(),
              //       //   style: Styles.mainTextStyle
              //       //       .copyWith(color: Colors.white),
              //       // ),
              //     ))
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: state.loadedCountriesList.length,
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                                  ? state.loadedCountriesList[index]
                                      .countryEnglishName
                                  : state.loadedCountriesList[index]
                                      .countryArabicName,
                              style: Styles.mainTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ],
    );
  }
}
