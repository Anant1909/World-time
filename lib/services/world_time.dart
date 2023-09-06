import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

class WorldTime {

  String location;
  String time = '';
  String flag;
  String url;
  bool isDayTime=true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    http.Response response =
    await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);

    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    //print(offset);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
     isDayTime = now.hour>6 && now.hour<19 ? true : false ;

    time = intl.DateFormat.jm().format(now);
  }
}
