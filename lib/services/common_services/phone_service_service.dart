
import 'package:url_launcher/url_launcher.dart';

class PhoneServiceService  {
  final String _phoneNumber = '+251889';

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: _phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
