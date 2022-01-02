import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/widgets/cities_item.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/get_activites/presentation/pages/main_activites_pages.dart';

class CitiesMobilePage extends StatelessWidget {
  final LoadedState state;
  final CountryEntity countryEntity;

  const CitiesMobilePage({required this.state, required this.countryEntity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(context.deviceLocale != "ar"
      //       ? countryEntity.countryEnglishName
      //       : countryEntity.countryArabicName),
      //   centerTitle: false,
      // ),
      body: state.loadedCitiesList.isEmpty
          ? Container(
              child: Center(
                child: CustomText(
                  text: "empty_list".tr(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  // snap: false,
                  floating: false,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(context.deviceLocale != "ar"
                        ? countryEntity.countryEnglishName
                        : countryEntity.countryArabicName),
                    centerTitle: false,
                    background: Container(
                      color: Colors.black26,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .20,
                      child: Image.network(
                        countryEntity.countryFlag,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CitiesItem(
                        state: state,
                        index: index,
                      );
                    },
                    childCount: state.loadedCitiesList.length,
                  ),
                ),
              ],

              // Column(children: [
              //     Container(
              //       color: Colors.black26,
              //       width: double.infinity,
              //       height: MediaQuery.of(context).size.height * .20,
              //       child: Image.network(
              //         countryEntity.countryFlag,
              //         fit: BoxFit.cover,
              //       ),
              //     )
              //   ],
            ),
    );
  }
}


