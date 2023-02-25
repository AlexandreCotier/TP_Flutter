import '../models/location.dart';
import '../models/locations_data.dart';
import 'location_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationApiData implements LocationApiClient{
  @override
  Future<List<Location>> getLocations(){
    return Future.delayed(
      const Duration(seconds: 1),
        () => LocationsData.buildList()
    );
  }

  @override
  Future<Location> getLocation(int id){
    Location location =
        LocationsData.buildList().
        where((element) => element.id == id).first;

  return Future.delayed(
      const Duration(seconds: 1),
      () => location);
  }
}

class LocationApiClientImpl implements LocationApiClient{
  @override
  Future<List<Location>> getLocations() async {
    var response = await http.get(Uri.parse('http://192.168.1.44:8888/api/locations/location.json'));
    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return List<Location>.from(jsonData.map((json) => Location.fromJson(json)));
    }else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Location> getLocation(int id) async {
    var response = await http.get(Uri.parse('http://localhost:8888/api/locations/location.json'));
    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      final locations = List<Location>.from(jsonData.map((json) => Location.fromJson(json)));
      return locations.firstWhere((element) => element.id == id);
    }else {
      throw Exception('Failed to load data');
    }
  }
}