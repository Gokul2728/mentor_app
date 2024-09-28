import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/Components/api.dart';
import 'package:mentor_app/Models/level_marks.dart';
import 'package:mentor_app/Models/profile.dart';
import 'package:mentor_app/Utils/color.dart';
import 'package:mentor_app/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.rollno});
  final String rollno;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<LevelMarks> levelMarks = [];
  List<PlacementMarks> placementMarks = [];
  StudentProfile? studentProfile;
  // List<dynamic> placementMarks = [];
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    dynamic profile = await apiPost(
        path: '/mentor/profile', body: {"roll_no": widget.rollno});

    if (profile['data']['data'] != null) {
      studentProfile = StudentProfile.fromJson(profile['data']['data']);
    }
    log('$studentProfile');
    dynamic response = await apiPost(
        path: '/mentor/placement', body: {"roll_no": widget.rollno});
    if (response['data']['data'] != null) {
      List<dynamic> responseData = response['data']['data'];
      placementMarks =
          responseData.map((json) => PlacementMarks.fromJson(json)).toList();

      log('$response');
    }

    dynamic response1 =
        await apiPost(path: '/mentor/ps', body: {"roll_no": widget.rollno});
    if (response1['data']['data'] != null) {
      List<dynamic> responseData = response1['data']['data'];
      levelMarks =
          responseData.map((json) => LevelMarks.fromJson(json)).toList();

      log('$response1');
    }

    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height / 2,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  mainColor.withOpacity(.7),
                  mainColor.withOpacity(.9),
                  mainColor
                ])),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height / 3.5),
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/star_pattern.png',
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: height / 22, left: 0, right: 30),
                  child: Column(
                    children: [
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //     vertical: 4,
                          //     horizontal: 10,
                          //   ),
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(5)),
                          //   child:
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 22,
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),

                          // ),
                          // IconButton(
                          //     style: IconButton.styleFrom(
                          //         backgroundColor: iconcolor,
                          //         // backgroundColor: Color.fromARGB(255, 165, 163, 215),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12))),
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.settings_rounded,
                          //       color: Colors.white,
                          //     ))
                        ],
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Text(
                                    studentProfile?.name ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      'SEM - ${studentProfile?.sem ?? ''} | Dept - ${studentProfile?.dept ?? ''}',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          letterSpacing: .8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      studentProfile?.year ?? '',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: CachedNetworkImage(
                                imageUrl: studentProfile?.profileImg ?? '',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: height / 1.33,
                width: width,
                padding: const EdgeInsets.only(
                    top: 25, left: 10, right: 10, bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      placementMarks.isEmpty
                          ? Center(
                              child: Container(),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, bottom: 10),
                                  child: Text(
                                    'Placement',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customCard(height, width,
                                        icon: Icons.groups_2_rounded,
                                        title: placementMarks
                                            .map((a) => a.level)
                                            .first,
                                        value: placementMarks
                                            .map((a) => a.marks)
                                            .first),
                                    customCard(height, width,
                                        icon: Icons.school_rounded,
                                        title: placementMarks
                                            .map((a) => a.level)
                                            .toList()[1],
                                        value: placementMarks
                                            .map((a) => a.marks)
                                            .toList()[1]),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: customCard(height, width,
                                      icon: Icons.stars,
                                      title: placementMarks
                                          .map((a) => a.level)
                                          .toList()[2],
                                      value: placementMarks
                                          .map((a) => a.marks)
                                          .toList()[2]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, bottom: 10, top: 15),
                                  child: Text(
                                    'PS Skill Levels',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              ],
                            ),
                      levelMarks.isEmpty
                          ? Center(
                              child: Container(),
                            )
                          : GridView.builder(
                              itemCount: levelMarks.length,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // crossAxisSpacing: 10.0,
                              ),
                              itemBuilder: (context, index) {
                                var item = levelMarks[index];
                                return customCard(height, width,
                                    icon: Icons.military_tech_rounded,
                                    title: item.level,
                                    textSize: 14,
                                    value: item.marks);
                              },
                            )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget customCard(height, width,
      {IconData? icon, String? value, String? title, double textSize = 16}) {
    return Container(
      height: height / 5.5,
      width: width / 2.4,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: backColor,
          border: Border.all(width: 0.7, color: mainColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 60,
                color: mainColor,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                value ?? '',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800),
              )
            ],
          ),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800),
          )
        ],
      ),
    );
  }
}
