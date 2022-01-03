import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/core/utils/localiztion_helper.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';
import 'package:home_travling/featuers/get_activites/presentation/pages/mobile/activity_detail_screen.dart';

import '../../../../styels.dart';

class ActivitesItem extends StatelessWidget {
  const ActivitesItem({
    Key? key,
    required this.state,
    required this.index,
    required this.localiztionHelper,
  }) : super(key: key);

  final LoadedState state;
  final LocaliztionHelper localiztionHelper;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ActivityDetailPage(
              activityEntity: state.loadedActivites[index],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                state.loadedActivites[index].activityImage,
                fit: BoxFit.cover,
                height: 150,
                // width: MediaQuery.of(context).size.width * 0.50,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            CustomText(
              text: localiztionHelper.checkLanguage(context) == "ar"
                  ? state.loadedActivites[index].activityArbaicName
                  : state.loadedActivites[index].activityEnglishName,
              style: Styles.mainTextStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
