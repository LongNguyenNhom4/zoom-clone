import 'package:flutter/material.dart';
import 'package:zoom_clone_tutorial/widgets/home_meeting_button.dart';
import 'package:zoom_clone_tutorial/resources/jitsi_meet_methods.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    if (!kIsWeb) {
      _jitsiMeetMethods.createMeeting(
          roomName: roomName, isAudioMuted: true, isVideoMuted: true);
    } else {
      _jitsiMeetMethods.createMeeting(
          roomName: roomName, isAudioMuted: true, isVideoMuted: true);
      var url = 'https://meet.jit.si/$roomName';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: createNewMeeting,
              text: 'New meeting',
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              text: 'Join meeting',
              icon: Icons.add_box_rounded,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Schedule',
              icon: Icons.calendar_today,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Share Screen',
              icon: Icons.arrow_upward_rounded,
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create new meeting with Long',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
