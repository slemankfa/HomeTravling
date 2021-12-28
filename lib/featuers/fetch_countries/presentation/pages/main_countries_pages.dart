import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/pages/web/countries_web_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../injection_container.dart';
import '../../../../../styels.dart';
import '../../../../core/utils/custom_text.dart';
import '../bloc/fetch_countries_bloc.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'mobile/countries_mobile_page.dart';

class MainCountriesScreen extends StatefulWidget {
  @override
  _MainCountriesScreenState createState() => _MainCountriesScreenState();
}

class _MainCountriesScreenState extends State<MainCountriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FetchCountriesBloc>()..add(GetCountriesListEvent()),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(16),
          child: BlocBuilder<FetchCountriesBloc, FetchCountriesState>(
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
                  ? CountriesMobilePage(
                      state: state,
                    )
                  : CountriesWebPage(
                      state: state,
                    );
            }

            return Container();
          }),
        ),
      ),
    );
  }
}
