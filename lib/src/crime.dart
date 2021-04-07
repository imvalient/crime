import 'exception/crime_exception.dart';
import 'model/crime_incidents.dart';
import 'model/crime_stats.dart';
import 'service/crime_client.dart';
import 'package:http/http.dart' as http;

import 'model/crime_coverage.dart';

class Crime {
  final String? apiKey;
  final CrimeClient _client = CrimeClientImpl();

  Crime({this.apiKey}) : assert(apiKey != null);

  /// Returns a list of [CrimeCoverage] data containing coverage information about crimes.
  ///
  /// Throws a [CrimeException].
  Future<List<CrimeCoverage>> getCrimeCoverageData() {
    final String? apiKey = this.apiKey;

    if (apiKey == null) {
      throw MandatoryApiKeyException("API Key it's a mandatory field", "001");
    }

    return _client
        .getCrimeCoverageData(apiKey, http.Client())
        .then((crimeCoverage) => crimeCoverage)
        .catchError((error) => throw error);
  }

  /// Returns a [CrimeRawIncidents] containing crime incidents information from an specific location.
  ///
  /// Throws a [CrimeException].
  Future<CrimeRawIncidents> getCrimeIncidents(double latitude, double longitude,
      String distance, DateTime startDateTime, DateTime endDateTime,
      {int page = 1}) {
    final String? apiKey = this.apiKey;

    if (apiKey == null) {
      throw MandatoryApiKeyException("API Key it's a mandatory field", "001");
    }

    return _client
        .getCrimeIncidents(latitude, longitude, distance, startDateTime,
            endDateTime, page, apiKey, http.Client())
        .then((crimeIncidents) => crimeIncidents)
        .catchError((error) => throw error);
  }

  /// Returns a [CrimeStats] with statistics about crime in an specific location.
  ///
  /// Throws a [CrimeException].
  Future<CrimeStats> getCrimeStats(double latitude, double longitude,
      String distance, DateTime startDateTime, DateTime endDateTime,
      {int source = 1}) {
    final String? apiKey = this.apiKey;

    if (apiKey == null) {
      throw MandatoryApiKeyException("API Key it's a mandatory field", "001");
    }

    return _client
        .getCrimeStats(latitude, longitude, distance, startDateTime,
            endDateTime, source, apiKey, http.Client())
        .then((crimeStats) => crimeStats)
        .catchError((error) => throw error);
  }

  /// Returns a [CrimeCrowdIncidents] containing crime incidents information from an specific location.
  /// The data is provided by the community.
  ///
  /// Throws a [CrimeException].
  Future<CrimeCrowdIncidents> getCrowdsourcedCrimeIncidents(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      {int page = 1}) {
    final String? apiKey = this.apiKey;

    if (apiKey == null) {
      throw MandatoryApiKeyException("API Key it's a mandatory field", "001");
    }

    return _client
        .getCrowdsourcedCrimeIncidents(latitude, longitude, distance,
            startDateTime, endDateTime, page, apiKey, http.Client())
        .then((crimeIncidents) => crimeIncidents)
        .catchError((error) => throw error);
  }
}
