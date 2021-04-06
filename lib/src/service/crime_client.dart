import 'dart:convert';

import '../exception/crime_exception.dart';

import '../utils/format_datetime.dart';
import 'package:http/http.dart' as http;

import '../model/crime_coverage.dart';
import '../model/crime_incidents.dart';
import '../model/crime_stats.dart';

abstract class CrimeClient {
  /// Returns a [List] of [CrimeCoverage] given an [apiKey] and [client].
  Future<List<CrimeCoverage>> getCrimeCoverageData(
      String apiKey, http.Client client);

  /// Return [CrimeIncidents] given a [latitude], [longitude], [distance],
  /// [startDateTime], [endDatetime], [page], [apiKey] and [client].
  Future<CrimeIncidents> getCrimeIncidents(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int page,
      String apiKey,
      http.Client client);

  /// Return [CrimeStats] given a [latitude], [longitude], [distance],
  /// [startDateTime], [endDateTime], [source], [apiKey], [client].
  Future<CrimeStats> getCrimeStats(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int source,
      String apiKey,
      http.Client client);

  /// Return [CrimeIncidents] given a [latitude], [longitude], [distance],
  /// [startDateTime], [endDateTime], [page], [apiKey], [client]
  Future<CrimeIncidents> getCrowdsourcedCrimeIncidents(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int page,
      String apiKey,
      http.Client client);
}

class CrimeClientImpl implements CrimeClient {
  /// API endpoint url
  final String url = 'api.crimeometer.com';

  @override
  Future<List<CrimeCoverage>> getCrimeCoverageData(
      String apiKey, http.Client client) {
    final String urlParams = "/v1/incidents/raw-data-coverage";

    final Uri uri = Uri.https(url, urlParams);

    return client.get(uri, headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey
    }).then((response) {
      switch (response.statusCode) {
        case 200:
          {
            return (json.decode(response.body)["cities"] as List)
                .map((crimes) => CrimeCoverage.fromJson(crimes))
                .toList();
          }
        case 429:
          {
            throw LimitExceededRequestException(
                json.decode(response.body)['message'], '429');
          }
        case 403:
          {
            throw ForbiddenRequestException(
                json.decode(response.body)['message'], '403');
          }
        default:
          {
            throw response.body;
          }
      }
    }).catchError((error) => throw error);
  }

  @override
  Future<CrimeIncidents> getCrimeIncidents(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int page,
      String apiKey,
      http.Client client) {
    final String urlParams = "/v1/incidents/raw-data";

    final Uri uri = Uri.https(url, urlParams, {
      "lat": latitude.toString(),
      "lon": longitude.toString(),
      "distance": distance.toString(),
      "datetime_ini": formatDateTime(startDateTime).toString(),
      "datetime_end": formatDateTime(endDateTime).toString(),
      "page": page.toString()
    });

    return client.get(uri, headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey
    }).then((response) {
      switch (response.statusCode) {
        case 200:
          {
            return CrimeIncidents.fromJson(json.decode(response.body));
          }
        case 429:
          {
            throw LimitExceededRequestException(
                json.decode(response.body)['message'], '429');
          }
        case 403:
          {
            throw ForbiddenRequestException(
                json.decode(response.body)['message'], '403');
          }
        default:
          {
            throw response.body;
          }
      }
    }).catchError((error) => throw error);
  }

  @override
  Future<CrimeStats> getCrimeStats(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int source,
      String apiKey,
      http.Client client) {
    final String urlParams = "/v1/incidents/stats";

    final Uri uri = Uri.https(url, urlParams, {
      "lat": latitude.toString(),
      "lon": longitude.toString(),
      "distance": distance.toString(),
      "datetime_ini": formatDateTime(startDateTime),
      "datetime_end": formatDateTime(endDateTime),
      "source": source.toString()
    });

    return client.get(uri, headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey
    }).then((response) {
      switch (response.statusCode) {
        case 200:
          {
            return CrimeStats.fromJson(json.decode(
                response.body.replaceAll(RegExp('"\"\""'), "\"unknown\"")));
          }
        case 429:
          {
            throw LimitExceededRequestException(
                json.decode(response.body)['message'], '429');
          }
        case 403:
          {
            throw ForbiddenRequestException(
                json.decode(response.body)['message'], '403');
          }
        default:
          {
            throw response.body;
          }
      }
    }).catchError((error) => throw error);
  }

  @override
  Future<CrimeIncidents> getCrowdsourcedCrimeIncidents(
      double latitude,
      double longitude,
      String distance,
      DateTime startDateTime,
      DateTime endDateTime,
      int page,
      String apiKey,
      http.Client client) {
    final String urlParams = "v1/incidents/crowdsourced-raw-data";

    final Uri uri = Uri.https(url, urlParams, {
      "lat": latitude.toString(),
      "lon": longitude.toString(),
      "distance": distance.toString(),
      "datetime_ini": formatDateTime(startDateTime).toString(),
      "datetime_end": formatDateTime(endDateTime).toString(),
      "page": page.toString()
    });

    return client.get(uri, headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey
    }).then((response) {
      switch (response.statusCode) {
        case 200:
          {
            return CrimeIncidents.fromJson(json.decode(response.body));
          }
        case 429:
          {
            throw LimitExceededRequestException(
                json.decode(response.body)['message'], '429');
          }
        case 403:
          {
            throw ForbiddenRequestException(
                json.decode(response.body)['message'], '403');
          }
        default:
          {
            throw response.body;
          }
      }
    }).catchError((error) => throw error);
  }
}
