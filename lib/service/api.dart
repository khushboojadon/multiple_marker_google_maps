import 'package:multiple_marker_google_maps/models/data.dart';
import 'package:http/http.dart' as http;

class Api {
  String url = "http://aryu.co.in/tracking/viewreport.php";

  Future<Data> getdetails() async {
    final response = await http.get(url);
    return dataFromJson(response.body);
  }
}
