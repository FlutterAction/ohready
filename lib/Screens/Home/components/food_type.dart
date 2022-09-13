import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Modals/Cuisine/Food%20Type/food_type_model.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';

class GetFoodType extends StatefulWidget {
  @override
  State<GetFoodType> createState() => _GetFoodTypeState();
}

class _GetFoodTypeState extends State<GetFoodType> {
  Future<List<FoodTypeModel>>? foodTypeListFuture;
  @override
  void initState() {
    if (APIManager.foodTypeList == null) {    
    getFoodTypeList();
    }else{
      foodTypeListFuture = APIManager.foodTypeList;
    }
    super.initState();
  }

  getFoodTypeList() {
    setState(() {
      foodTypeListFuture = APIManager().getFoodType(context);
      APIManager.foodTypeList = foodTypeListFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
      height: 110,
      child: FutureBuilder<List<FoodTypeModel>>(
        future: foodTypeListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<FoodTypeModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Container(
                  width: 25, height: 25, child: CircularProgressIndicator()),
            );
          if (snapshot.data == null || snapshot.hasError)
            return ServerError(
              onPressed: () {
                getFoodTypeList();
              },
              text: 'Network Error. Try Again',
            );
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return FoodTypeCard(
                foodType: snapshot.data![index],
              );
            },
          );
        },
      ),
    );
  }
}

class FoodTypeCard extends StatelessWidget {
  final FoodTypeModel? foodType;
  const FoodTypeCard({@required this.foodType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        MyProvider provider = Provider.of<MyProvider>(context, listen: false);
        APIManager.foodTypeCode = foodType!.foodTypeCode;
          screenIndex = 1;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> provider.loginResponse != null ? MyHomePage(): AppHomePage()), (route) => false);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              height: 80,
              width: 80,
              child: foodType!.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network("${foodType!.imagePath}",
                          fit: BoxFit.cover),
                    )
                  : Icon(Icons.image_outlined),
            ),
            SizedBox(height: 5),
            Text(
              '${foodType!.foodTypeName}',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
