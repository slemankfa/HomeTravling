import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/error_widget.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/loading_widget.dart';
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
              // print("loaded" + state.loadedCountriesList.length.toString());
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: state.loadedCountriesList.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              state.loadedCountriesList[index].countryFlag)),
                      color: Colors.red),
                ),
                staggeredTileBuilder: (int index) =>
                    const StaggeredTile.count(1, 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
            }
            return Container();
            // return Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [],
            // );
          }),
        ),
      ),
    );
  }
}
