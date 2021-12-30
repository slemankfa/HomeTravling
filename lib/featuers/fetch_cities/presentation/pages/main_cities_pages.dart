import 'package:dartz/dartz_streaming.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/featuers/fetch_cities/domain/usecases/get_cities_list.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/pages/mobile/cities_mobile_page.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/pages/web/cities_web_page.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/pages/web/countries_web_page.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/error_widget.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/loading_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../injection_container.dart';

class MainCitiesScreen extends StatefulWidget {
  MainCitiesScreen({required this.country});

  @override
  _MainCitiesScreenState createState() => _MainCitiesScreenState();
  final CountryEntity country;
}

class _MainCitiesScreenState extends State<MainCitiesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FetchCitiesBloc>()
        ..add(GetCitiesListEvent(countryId: widget.country.countryId)),
      child: BlocBuilder<FetchCitiesBloc, FetchCitiesState>(
          builder: (context, state) {
        if (state is LoadingState) {
          return const Loading();
        }
        if (state is ErrorState) {
          return ErrorMessage(
            message: state.message,
          );
        } else if (state is LoadedState) {
          return ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              ? CitiesMobilePage(
                  state: state,
                  countryEntity: widget.country,
                )
              : CitiesWebPage(
                  state: state,
                  countryEntity: widget.country,
                );
        }

        return Container();
      }),
    );
  }
}
