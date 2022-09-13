import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static Future openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }
}
