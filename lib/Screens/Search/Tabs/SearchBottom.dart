import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';

class SearchTabs extends StatelessWidget {
  const SearchTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return TabCard(
            index: index,
          );
        },
      ),
    );
  }
}

class TabCard extends StatelessWidget {
  final int? index;
  const TabCard({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(right: 10),
            height: 30,
            child: Center(
              child: Text(
                "ALL",
                style: TextStyle(color: Colors.white),
              ),
            )),
      ],
    );
  }
}
