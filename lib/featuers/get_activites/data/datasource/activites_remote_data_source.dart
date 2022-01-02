import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_travling/featuers/get_activites/data/model/activity_model.dart';

abstract class ActivitiesRemoteDataSource {
  /// calls activities collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<ActivityModel>> getActivitiesList(String cityId);
}

class ActivitiesRemoteDataSourceImpl implements ActivitiesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ActivitiesRemoteDataSourceImpl(this.firebaseFirestore);
  @override
  Future<List<ActivityModel>> getActivitiesList(String cityId) async {
    // TODO: implement getActivitiesList
    List<ActivityModel> activites = [];
    final loadedActivites = await firebaseFirestore
        .collection("activities")
        .where("city.city_id", isEqualTo: cityId)
        .get();

    for (var item in loadedActivites.docs) {
      activites.add(ActivityModel.fromJson(item.data()));
    }
    return activites;
  }
}
