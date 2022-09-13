import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';


class MyButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  const MyButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        // width: size.width / 1.2,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
                image: AssetImage('assets/btn.png'), fit: BoxFit.cover)),
        child: Center(
          child: Text(
            text.toString(),
            style: TextStyle(
                color: btntextColor, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ),
    );
  }
}





// ignore: must_be_immutable
class CartButton extends StatelessWidget {
  final String? text;
   var count;
   var total;
  final Function()? onPressed;
   CartButton({@required this.text,@required this.count,@required this.total, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        // width: size.width / 1.2,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage('assets/btn.png'), fit: BoxFit.cover)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 20,
              width: 20,              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white,width: 2),
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: TextStyle(
                      color: btntextColor, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            Text(
              text.toString(),
              style: TextStyle(
                  color: btntextColor, fontWeight: FontWeight.bold, fontSize: 13),
            ),

            Text(
              "$total",
              style: TextStyle(
                  color: btntextColor, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

