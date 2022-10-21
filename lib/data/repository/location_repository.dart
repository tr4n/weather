import 'package:geocoding/geocoding.dart';

class LocationRepository {
  LocationRepository();

  Future<List<Placemark>> getPlaceMark(String lat, String lon) =>
      placemarkFromCoordinates(double.parse(lat), double.parse(lon));
}
