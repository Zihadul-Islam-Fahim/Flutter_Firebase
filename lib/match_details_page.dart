import 'package:flutter/material.dart';

class MatchDetailspage extends StatelessWidget {
  final match;

  const MatchDetailspage(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(match.matchName.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text(
                    match.matchName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey),
                  ),
                  Text(match.score,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
                  Text("Time : " + match.time,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("Total Time : " + match.totalTime,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
