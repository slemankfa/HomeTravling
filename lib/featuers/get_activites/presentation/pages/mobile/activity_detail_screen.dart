import 'package:flutter/material.dart';
import 'package:home_travling/core/utils/custom_text.dart';
import 'package:home_travling/core/utils/localiztion_helper.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../styels.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key, required this.activityEntity})
      : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
  final ActivityEntity activityEntity;
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  LocaliztionHelper localiztionHelper = LocaliztionHelper();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = YoutubePlayerController(
      initialVideoId: widget.activityEntity.activityVideo,
      params: YoutubePlayerParams(
        // Defining custom playlist
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomText(
                text: localiztionHelper.checkLanguage(context) == "ar"
                    ? widget.activityEntity.activityArbaicName
                    : widget.activityEntity.activityEnglishName,
                style: Styles.mainTextStyle
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              YoutubePlayerControllerProvider(
                // Provides controller to all the widget below it.
                controller: _controller,
                child: YoutubePlayerIFrame(
                  aspectRatio: 16 / 9,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CustomText(
                text: widget.activityEntity.activityDescription,
                style: Styles.mainTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
