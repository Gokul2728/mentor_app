import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/Components/api.dart';
import 'package:mentor_app/Packages/fade_transition/proste_route_animation.dart';
import 'package:mentor_app/Pages/DataGrid/home_table.dart';
import 'package:mentor_app/Pages/profile.dart';
import 'package:mentor_app/Storage/storage_service.dart';
import 'package:mentor_app/Utils/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageSource homeSource;
  final DataGridController dataGridController = DataGridController();
  String? email, name, img, id, role;

  @override
  void initState() {
    super.initState();
    init();
    homeSource = HomePageSource(data: list, context: context);
  }

  init() async {
    email = await StorageService().getStringData('email');
    name = await StorageService().getStringData('name');
    img = await StorageService().getStringData('profile_img');
    id = await StorageService().getStringData('id');
    role = await StorageService().getStringData('role');
    //
    dynamic response =
        await apiPost(path: '/mentor/list', body: {"email": "$email"});
    log(response.toString());
    setState(() {});
    return;
  }

  List<dynamic> list = [
    {
      'no': '7376222CS122',
      'name': 'Gokul',
      'rank': '21',
      'score': '1500',
      'group': 'A',
      'levels': '7376222CS122',
    },
    {
      'no': '7376222CS121',
      'name': 'Siva',
      'rank': '22',
      'score': '1500',
      'group': 'B',
      'levels': '7376222CS121',
    },
    {
      'no': '7376222CS122',
      'name': 'Rajaa',
      'rank': '22',
      'score': '1500',
      'group': 'B',
      'levels': '7376222CS122',
    },
    {
      'no': '7376222CS122',
      'name': 'Bala',
      'rank': '22',
      'score': '1500',
      'group': 'B',
      'levels': '7376222CS122',
    },
    {
      'no': '7376222CS121',
      'name': 'Vinith',
      'rank': '22',
      'score': '1500',
      'group': 'B',
      'levels': '7376222CS121',
    }
  ];
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
                      EdgeInsets.only(top: height / 16, left: 30, right: 30),
                  child: Column(
                    children: [
                      //
                      const Row(
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
                          Text(
                            'Dashboard',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Text(
                                  '$name',
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
                                    role == 'Student'
                                        ? 'Year - III | Dept - MECH'
                                        : role == 'Admin'
                                            ? '$email'
                                            : '',
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    role == 'Student' ? '2024 - 2028' : '$id',
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
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: CachedNetworkImage(
                              imageUrl: '$img',
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
                padding: const EdgeInsets.only(top: 25, left: 10, bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Student Details',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700),
                          ),
                        )
                      ],
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.only(top: 20),
                    //     itemCount: 20,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         padding: const EdgeInsets.symmetric(
                    //           vertical: 8.0,
                    //           horizontal: 8.0,
                    //         ),
                    //         decoration: BoxDecoration(),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '7376211cs23',
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Colors.grey.shade600,
                    //                       fontWeight: FontWeight.w500),
                    //                 ),
                    //                 Text(
                    //                   'Suthakar N',
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Colors.grey.shade700,
                    //                       fontWeight: FontWeight.w500),
                    //                 ),
                    //                 IconButton.outlined(
                    //                     onPressed: () {},
                    //                     icon: Icon(
                    //                         Icons.arrow_forward_ios_rounded))
                    //               ],
                    //             ),
                    //             const SizedBox(
                    //               height: 5,
                    //             ),
                    //             Divider(
                    //               color: Colors.grey.shade200,
                    //               height: 0.4,
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      // decoration: ShapeDecoration(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20))),
                      child: SfDataGrid(
                          controller: dataGridController,
                          source: homeSource,
                          frozenColumnsCount: 1,
                          isScrollbarAlwaysShown: true,
                          columns: [
                            gridColumn(
                              param: 'Roll no',
                              text: 'Roll no',
                              width: width / 3,
                            ),
                            gridColumn(
                                param: 'Name', text: 'Name', width: width / 3),
                            gridColumn(
                                param: 'Placement Rank',
                                text: 'Placement Rank',
                                width: width / 3),
                            gridColumn(
                                param: 'Placement Score',
                                text: 'Placement Score',
                                width: width / 3),
                            gridColumn(
                                param: 'Placement Group',
                                text: 'Placement Group',
                                width: width / 3),
                            gridColumn(
                                param: 'PS Levels',
                                text: 'PS Levels',
                                width: width / 3),
                          ]),
                    ))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: mainColor,
      //   shape: const CircleBorder(),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         ProsteRouteAnimation(
      //           builder: (context) => const ProfilePage(),
      //         ));
      //   },
      //   child: const Icon(
      //     CupertinoIcons.person_crop_circle,
      //     size: 35,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  GridColumn gridColumn(
      {String? text,
      String? param,
      BorderRadius radius = BorderRadius.zero,
      double width = double.nan}) {
    double height = MediaQuery.sizeOf(context).height;
    return GridColumn(
      columnName: param!,
      width: width,
      label: Container(
        decoration: BoxDecoration(color: mainColor, borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        alignment: Alignment.center,
        child: Text(
          text!,
          style: TextStyle(
              fontSize: width < 500 ? 13 : 18,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
