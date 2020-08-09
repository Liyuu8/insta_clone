import 'package:geolocator/geolocator.dart';

// data models
import 'package:insta_clone/data_models/location.dart';

class LocationManager {
  Future<Location> getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final placeMarks = await Geolocator().placemarkFromPosition(position);
    return Future.value(_convert(placeMarks.first));
  }

  Future<Location> updateLocation(double latitude, double longitude) async {
    final placeMarks =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    return Future.value(_convert(placeMarks.first));
  }

  Location _convert(Placemark placeMark) => Location(
        latitude: placeMark.position.latitude,
        longitude: placeMark.position.longitude,
        country: placeMark.country,
        state: placeMark.administrativeArea,
        city: placeMark.locality,
      );
}
