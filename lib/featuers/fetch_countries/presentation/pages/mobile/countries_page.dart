import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("sadasdasd")],
      ),
    );
  }
}
