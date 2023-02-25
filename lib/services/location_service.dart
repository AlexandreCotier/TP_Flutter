import 'package:location/models/location.dart';
import 'package:location/models/locations_data.dart';

import 'location_api_data.dart';

class LocationService {
  final LocationApiClientImpl locationApiClient;

  LocationService() :
      locationApiClient = LocationApiClientImpl();

  Future<List<Location>> getLocations() async {
    List<Location> list = await locationApiClient.getLocations();
    return list;
  }

  Future<Location> getLocation(int id){
    return locationApiClient.getLocation(id);
  }
}

abstract class LocationApiClient{
  Future<List<Location>> getLocations();
  Future<Location> getLocation(int id);
}