import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/app_localization.dart';
import '../../../../Components/constants.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({Key? key}) : super(key: key);

  @override
  _AppLanguageState createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  int? groupValue;
  @override
  void initState() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    if (provider.appLocale == Locale('en', '')) {
      groupValue = 0;
    } else {
      groupValue = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: appBar(context,
            title: AppLocalizations.of(context).translate('appLanguage')),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  handleValueChange(0);
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/en.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text('English'),
                    trailing: Radio(
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (int? value) {
                        handleValueChange(value);
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  handleValueChange(1);
                },
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/es.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text('Spanish'),
                    trailing: Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (int? value) {
                        handleValueChange(value);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  handleValueChange(int? value) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    if (value == 0) {
      provider.changeLanguage(Locale('en', ''));
      setState(() {
        groupValue = 0;
      });
    } else {
      provider.changeLanguage(Locale('es', ''));
      setState(() {
        groupValue = 1;
      });
    }
  }
}
