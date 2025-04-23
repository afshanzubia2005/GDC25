import 'package:http/http.dart' as http;
import 'dart:convert'; // for jsonDecode
// as of now, this file defines a hardcoded addess value and defines  a function main() that can be used to get its lat/lon coordinates

const addressString = '2013 Deer Ridge Drive, Red Bank NJ 07701';

String buildQuery(String address) {
  final uriAddress = Uri.encodeComponent(address);
  return "https://nominatim.openstreetmap.org/search?q=$uriAddress&format=jsonv2";
}

Future<List> main(addressString) async {
  // call to take hardcoded address and get coordinates

  String query = buildQuery(addressString);
  //print(query);
  final url = Uri.parse(query);
  //print(url);

  final response = await http.get(
    url,
    headers: {'User-Agent': 'HopeLinker (aa3526@njit.edu)', 'Accept': 'jsonv2'},
  );
  final List<dynamic> data = jsonDecode(response.body);
  final List<dynamic> coordinates = [data[0]["lat"], data[0]["lon"]];
  //print(coordinates);
  return coordinates;
  //print(response.body.toString());
}
