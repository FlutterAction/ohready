import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';

class MenuList extends StatefulWidget {
  final List<Menu>? menuList;
  const MenuList({@required this.menuList});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  int selectedIndex = 0;

  @override
  void initState() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    provider.itemList = null;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.menuList!.isNotEmpty) {
        provider.saveItemList(widget.menuList![0].itemsList);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.menuList!.isEmpty
        ? Container()
        : Consumer<MyProvider>(builder: (context, provider, child) {
            return Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.menuList!.length,
                  itemBuilder: (context, index) {
                    return MenuCard(
                      menu: widget.menuList![index],
                      currentIndex: index,
                      selectedIndex: selectedIndex,
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        provider
                            .saveItemList(widget.menuList![index].itemsList);
                      },
                    );
                  },
                ));
          });
  }
}

class MenuCard extends StatefulWidget {
  final Menu? menu;
  final int? currentIndex;
  final int? selectedIndex;
  final Function()? onPressed;
  const MenuCard(
      {@required this.menu,
      @required this.currentIndex,
      @required this.selectedIndex,
      @required this.onPressed});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: widget.onPressed,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: widget.selectedIndex == widget.currentIndex
                    ? primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(right: 10),
            height: 30,
            child: Center(
              child: Text(
                widget.menu!.name.toString(),
                style: TextStyle(
                    color: widget.selectedIndex == widget.currentIndex
                        ? Colors.white
                        : Colors.black54),
              ),
            )),
      );
    });
  }
}
