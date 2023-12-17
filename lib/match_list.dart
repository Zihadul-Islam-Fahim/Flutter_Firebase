import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/match_details_page.dart';
import 'package:flutter/material.dart';
import 'match_class.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key});

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Match> matchList = [];
  late final table = _firebaseFirestore.collection("matchScore");

  // Future<void> getmatchList() async {
  //   matchList.clear();
  //
  //   final QuerySnapshot data = await table.get();
  //   for (QueryDocumentSnapshot element in data.docs) {
  //     Match match = Match(
  //         matchName: element["Teams"],
  //         score: element["Score"],
  //         time: element["Time"],
  //         totalTime: element["TotalTime"]);
  //     matchList.add(match);
  //     setState(() {});
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // getmatchList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
      ),
      body: StreamBuilder(
          stream: table.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              matchList.clear();
              for (QueryDocumentSnapshot element in snapshot.data!.docs) {
                Match match = Match(
                    matchName: element["Teams"],
                    score: element["Score"],
                    time: element["Time"],
                    totalTime: element["TotalTime"]);
                matchList.add(match);
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: matchList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      trailing: const Icon(Icons.arrow_forward),
                      title: Text(
                        matchList[index].matchName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MatchDetailspage(matchList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            else{
              return const Center(child: LinearProgressIndicator());
            }
          }
          ),
    );
  }
}
