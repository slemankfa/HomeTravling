import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';

List<CityEntity> tCitiesList = const [
  CityEntity(
      cityArabicName: "بارما",
      cityId: "1",
      countryId: "1",
      cityImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
      cityEnaglishName: "Parma")
];

CityModel tCityModel = CityModel(
    cityEnglishName: "Parma",
    cityArabicName: "بارما",
    cityId: "1",
    cityImage:
        "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
    countryId: "1");
