import 'dart:math' as math;

double distanceInMetersBetween(
    Map<String, double> location1, Map<String, double> location2) {
  const int EARTH_RADIUS = 6371000; // Earth's radius in meters
  double latDelta =
      degreesToRadians(location2["latitude"] - location1["latitude"]);
  double lonDelta =
      degreesToRadians(location2["longitude"] - location1["longitude"]);

  double a = (math.sin(latDelta / 2) * math.sin(latDelta / 2)) +
      (math.cos(degreesToRadians(location1["latitude"])) *
          math.cos(degreesToRadians(location2["latitude"])) *
          math.sin(lonDelta / 2) *
          math.sin(lonDelta / 2));

  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  return EARTH_RADIUS * c;
}

Map<String, Map<String, double>> boundingBoxCoordinates(
    num centerLatitude, num centerLongitude, num radiusInKm) {
  const KM_PER_DEGREE_LATITUDE = 110.574;
  double latDegrees = radiusInKm / KM_PER_DEGREE_LATITUDE;
  double latitudeNorth = math.min(90, centerLatitude + latDegrees);
  double latitudeSouth = math.max(-90, centerLatitude - latDegrees);
  // calculate longitude based on current latitude
  double longDegsNorth =
      metersToLongitudeDegrees(1000 * radiusInKm, latitudeNorth);
  double longDegsSouth =
      metersToLongitudeDegrees(1000 * radiusInKm, latitudeSouth);
  double longDegs = math.max(longDegsNorth, longDegsSouth);
  return {
    "swCorner": {
      // bottom-left (SW corner)
      "latitude": latitudeSouth,
      "longitude": wrapLongitude(centerLongitude - longDegs),
    },
    "neCorner": {
      // top-right (NE corner)
      "latitude": latitudeNorth,
      "longitude": wrapLongitude(centerLongitude + longDegs),
    },
  };
}

double degreesToRadians(double degrees) {
  return (degrees * math.pi) / 180;
}

///Calculates the number of degrees a given distance is at a given latitude
double metersToLongitudeDegrees(double distance, double latitude) {
  const EARTH_EQ_RADIUS = 6378137.0;
  // this is a super, fancy magic number that the GeoFire lib can explain (maybe)
  const double E2 = 0.00669447819799;
  const double EPSILON = 1e-12;
  double radians = degreesToRadians(latitude);
  double numerator = math.cos(radians) * EARTH_EQ_RADIUS * math.pi / 180;
  double denominator =
      1 / math.sqrt(1 - E2 * math.sin(radians) * math.sin(radians));
  double deltaDeg = numerator * denominator;
  if (deltaDeg < EPSILON) {
    return distance > 0 ? 360 : 0;
  }
  // else
  double calc = distance / deltaDeg;
  return math.min(360.0, calc);
}

///Wraps the longitude to [-180,180].
double wrapLongitude(double longitude) {
  if (longitude <= 180 && longitude >= -180) {
    return longitude;
  }
  double adjusted = longitude + 180;
  if (adjusted > 0) {
    return (adjusted % 360) - 180;
  }
  // else
  return 180 - (-adjusted % 360);
}
