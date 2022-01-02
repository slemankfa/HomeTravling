import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../injection_container.dart';
import '../../../fetch_countries/domain/entities/country_entity.dart';
import '../../../fetch_countries/presentation/widgets/error_widget.dart';
import '../../../fetch_countries/presentation/widgets/loading_widget.dart';
import '../bloc/fetch_cities_bloc.dart';
import 'mobile/cities_mobile_page.dart';
import 'web/cities_web_page.dart';

class MainCitiesPages extends StatefulWidget {
  MainCitiesPages({required this.country});

  @override
  _MainCitiesPagesState createState() => _MainCitiesPagesState();
  final CountryEntity country;
}

class _MainCitiesPagesState extends State<MainCitiesPages> {
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
