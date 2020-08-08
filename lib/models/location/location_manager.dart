import 'package:geolocator/geolocator.dart';

// data models
import 'package:insta_clone/data_models/location.dart';

class LocationManager {
  Future<Location> getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final placeMarks = await Geolocator().placemarkFromPosition(position);
    final placeMark = placeMarks.first;
    return Future.value(_convert(placeMark));
  }

  Location _convert(Placemark placeMark) => Location(
        latitude: placeMark.position.latitude,
        longitude: placeMark.position.longitude,
        country: placeMark.country,
        state: placeMark.administrativeArea,
        city: placeMark.locality,
      );
}
