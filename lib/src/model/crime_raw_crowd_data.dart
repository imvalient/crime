import '../utils/try_parse.dart';

class CrimeRawCrowdData {
  /// Incident code provided by the source.
  final String? incidentCode;

  /// Incident Latitude
  final double? incidentLatitude;

  /// Incident Longitude.
  final double? incidentLongitude;

  const CrimeRawCrowdData(
      {this.incidentCode, this.incidentLatitude, this.incidentLongitude});

  factory CrimeRawCrowdData.fromJson(Map<String, dynamic> crimeRawData) =>
      CrimeRawCrowdData(
          incidentCode: tryParse(crimeRawData['incident_code']),
          incidentLatitude: crimeRawData['incident_latitude'],
          incidentLongitude: crimeRawData['incident_longitude']);

  @override
  String toString() =>
      "[CrimeRawCrowdData]: {incidentCode=$incidentCode, incidentLatitude=$incidentLatitude, incidentLongitude=$incidentLongitude}";
}
