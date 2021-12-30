import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/widgets/countries_item.dart';

import '../../../../../styels.dart';

class CountriesMobilePage extends StatelessWidget {
  const CountriesMobilePage({
    Key? key,
    required this.state,
  }) : super(key: key);

  final LoadedState state;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: state.loadedCountriesList.length,
      itemBuilder: (BuildContext context, int index) => CountriesItem(
        state: state,
        index: index,
      ),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       height: 200,
      //       width: 300,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //       child: Stack(
      //         children: [
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(15.0),
      //             child: Image.network(
      //               state.loadedCountriesList[index].countryFlag,
      //               fit: BoxFit.fill,
      //               height: 200,
      //               width: 300,
      //               // width: 100,
      //             ),
      //           ),
      //           Positioned(
      //             bottom: 0,
      //             left: 0,
      //             right: 0,
      //             child: Container(
      //               height: 50,
      //               decoration: const BoxDecoration(
      //                 color: Colors.black45,
      //                 borderRadius: BorderRadius.only(
      //                   bottomLeft: Radius.circular(15),
      //                   bottomRight: Radius.circular(15),
      //                 ),
      //               ),
      //               child: Container(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(
      //                   state.loadedCountriesList[index].countryEnglishName,
      //                   style:
      //                       Styles.mainTextStyle.copyWith(color: Colors.white),
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 15,
      //     ),
      //   ],
      // ),

      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
