
import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';

class FilterItemList extends StatelessWidget {
  const FilterItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 0.8,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(
            20,
            (index) => Card(
                  color: Colors.amber,
                  child: Center(child: Text('$index')),
                )));
  }
}

class Card extends StatelessWidget {
  const Card({Key? key, required MaterialColor color, required Center child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // push(context, ItemDetails());
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Caramel cake with beries",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "\$ 64",
                    style: TextStyle(color: textColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
