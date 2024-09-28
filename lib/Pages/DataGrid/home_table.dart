import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/Components/api.dart';
import 'package:mentor_app/Models/break_points.dart';
import 'package:mentor_app/Pages/profile.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../Packages/fade_transition/proste_route_animation.dart';
import '../../Utils/color.dart';

class HomePageSource extends DataGridSource {
  HomePageSource({required List<dynamic> data, required this.context}) {
    _homeData = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Roll no', value: e['no']),
              DataGridCell<String>(columnName: 'Name', value: e['name']),
              DataGridCell<String>(
                  columnName: 'Placement Rank', value: e['rank']),
              DataGridCell<String>(
                  columnName: 'Placement Score', value: e['score']),
              DataGridCell<String>(
                  columnName: 'Placement Group', value: e['group']),
              DataGridCell<String>(columnName: 'PS Levels', value: e['levels']),
            ]))
        .toList();
  }

  final BuildContext context;
  List<DataGridRow> _homeData = [];
  List<BreakPoints> breakPoints = [];
  bool noData = false;
  @override
  List<DataGridRow> get rows => _homeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    List<Color> loopColor = [
      mainColor.withOpacity(.1),
      Colors.white,
    ];
    int rowIndex = _homeData.indexOf(row);
    Color rowColor = loopColor[rowIndex % loopColor.length];

    //
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'Placement Score') {
          String rollNo = row
              .getCells()
              .firstWhere((cell) => cell.columnName == 'Roll no')
              .value as String;

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: rowColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(e.value),
                //
                StatefulBuilder(
                  builder: (context, setState) {
                    return PopupMenuButton(
                      tooltip: '',
                      offset: const Offset(0, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      splashRadius: 1,
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                      ),
                      onOpened: () async {
                        log(rollNo);
                        setState(() {
                          noData = false;
                        });
                        dynamic response = await apiPost(
                            path: '/mentor/break_points',
                            body: {"roll_no": rollNo ?? ""});
                        List<dynamic> data = response['data']['data'];
                        if (data != null) {
                          breakPoints = data
                              .map((json) => BreakPoints.fromJson(json))
                              .toList();
                          log('${breakPoints.map((e) => e.bpTitle)}');
                        } else {
                          setState(() {
                            noData = true;
                          });
                        }

                        return;
                      },
                      itemBuilder: (context) {
                        return <PopupMenuEntry>[
                          PopupMenuItem(
                            enabled: false,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Title',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    Text(
                                      'Points',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                                noData
                                    ? const Center(
                                        child: Text('No data found'),
                                      )
                                    : breakPoints.isEmpty
                                        ? const CircularProgressIndicator()
                                        : SizedBox(
                                            height: 200,
                                            width: 140,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: ListView.builder(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                itemCount: breakPoints.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  var item = breakPoints[index];
                                                  DateTime notificationDate =
                                                      DateFormat(
                                                              'yyyy-MM-dd HH:mm:ss')
                                                          .parse(item.date);

                                                  var timeDifference =
                                                      DateTime.now().difference(
                                                          notificationDate);
                                                  int month =
                                                      notificationDate.month;
                                                  String formattedTime;
                                                  if (timeDifference.inSeconds <
                                                      60) {
                                                    formattedTime =
                                                        "${timeDifference.inSeconds} seconds ago";
                                                  } else if (timeDifference
                                                          .inMinutes <
                                                      60) {
                                                    formattedTime =
                                                        "${timeDifference.inMinutes} minutes ago";
                                                  } else if (timeDifference
                                                          .inHours <
                                                      24) {
                                                    formattedTime =
                                                        "${timeDifference.inHours} hours ago";
                                                  } else if (timeDifference
                                                          .inDays <=
                                                      1) {
                                                    formattedTime =
                                                        "${timeDifference.inDays} day ago";
                                                  } else if (timeDifference
                                                          .inDays <
                                                      100000) {
                                                    formattedTime =
                                                        "${timeDifference.inDays} days ago";
                                                  } else {
                                                    formattedTime = DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(
                                                            notificationDate);
                                                  }

                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          item.bpTitle,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(item.points,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                            formattedTime,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        8)),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                              ],
                            ),
                          ),
                        ];
                      },
                    );
                  },
                )
              ],
            ),
          );
        } else if (e.columnName == 'PS Levels') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: rowColor),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                log('${e.value}');
                Navigator.push(
                  context,
                  ProsteRouteAnimation(
                    builder: (context) => ProfilePage(rollno: '${e.value}'),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("View"),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: rowColor),
            child: Text(e.value.toString()),
          );
        }
      }).toList(),
    );
  }
}

   // InkWell(
                //   onTap: () {
                //     log(rollNo);

                //     showPopover(
                //       context: context,
                //       width: 300,
                //       height: 400,
                //       onPop: () => print('Popover was popped!'),
                //       direction: PopoverDirection.bottom,
                //       backgroundColor: Colors.white,
                //       arrowHeight: 15,
                //       arrowWidth: 30,
                //       bodyBuilder: (context) {
                //         return Padding(
                //           padding: const EdgeInsets.all(3),
                //           child: ListView.builder(
                //             itemCount: 5,
                //             reverse: true,
                //             itemBuilder: (context, index) {
                //               return Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text('Review $index'),
                //                   Text('$rollNo'),
                //                   Text('2024-09-05 14:57:48'),
                //                 ],
                //               );
                //             },
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //     child: Icon(
                //       Icons.info_outline_rounded,
                //       color: Colors.grey.shade500,
                //       size: 20,
                //     ),
                //   ),
                // ),
             