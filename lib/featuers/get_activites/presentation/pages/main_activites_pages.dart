import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/error_widget.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/loading_widget.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';
import 'package:home_travling/featuers/get_activites/presentation/pages/mobile/activites_mobile_page.dart';
import 'package:home_travling/featuers/get_activites/presentation/pages/web/activites_web_page.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../injection_container.dart';

class MainActivitesPages extends StatefulWidget {
  final CityEntity city;
  final CountryEntity countryEntity;

  MainActivitesPages({required this.city, required this.countryEntity});
  @override
  _MainActivitesPagesState createState() => _MainActivitesPagesState();
}

class _MainActivitesPagesState extends State<MainActivitesPages> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FetchActivitiesBloc>()
        ..add(
          GetActivitiesEvent(cityId: widget.city.cityId),
        ),
      child: BlocBuilder<FetchActivitiesBloc, FetchActivitiesState>(
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
                ? ActivitiesMobilePage(
                    state: state,
                    cityEntity: widget.city,
                    countryEntity: widget.countryEntity,
                  )
                : ActivitiesWebPage(
                    state: state,
                    cityEntity: widget.city,
                  );
          }

          return Container();
        },
      ),
    );
  }
}
