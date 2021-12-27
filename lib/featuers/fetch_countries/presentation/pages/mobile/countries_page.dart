import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../injection_container.dart';

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    fetchCountries();
    super.initState();
  }

  void fetchCountries() async {
    // await Provider.of<CountriesProvider>(context, listen: false)
    //     .fetchCountriesList()
    //     .then((informationMap) {
    //   setState(() {
    //     // _isThereNextPage = informationMap["isThereNextPage"] ?? false;
    //     // _pageNumber++;
    //     // popUpProgressIndcator.call();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FetchCountriesBloc>()..add(GetCountriesListEvent()),
      child: Scaffold(
        body: BlocBuilder<FetchCountriesBloc, FetchCountriesState>(
            builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is LoadedState) {
            print("loaded" + state.loadedCountriesList.length.toString());
          }
          return Container();
          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [],
          // );
        }),
      ),
    );
  }
}
