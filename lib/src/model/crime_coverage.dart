import '../utils/try_parse.dart';

class CrimeCoverage {
  /// The name of the city.
  final String? cityName;

  /// The amount of incidents.
  final int? incidentsQuantity;

  /// The key of the city.
  final String? cityKey;

  /// The date of the first incident.
  final DateTime? firstIncidentDate;

  /// The date of the last incident.
  final DateTime? lastIncidentDate;

  const CrimeCoverage(
      {this.cityName,
      this.incidentsQuantity,
      this.cityKey,
      this.firstIncidentDate,
      this.lastIncidentDate});

  factory CrimeCoverage.fromJson(Map<String, dynamic> crimeCoverage) =>
      CrimeCoverage(
          cityName: tryParse(crimeCoverage['city_name']),
          incidentsQuantity: crimeCoverage['incidents_quantity'],
          cityKey: tryParse(crimeCoverage['city_key']),
          firstIncidentDate: DateTime.tryParse(
              tryParse(crimeCoverage['first_incident_date']) ?? ''),
          lastIncidentDate: DateTime.tryParse(
              tryParse(crimeCoverage['last_incident_date']) ?? ''));

  @override
  String toString() =>
      "[CrimeCoverage]: {cityName=$cityName, incidentsQuantity=$incidentsQuantity, " +
      "cityKey=$cityKey, firstIncidentDate=$firstIncidentDate, " +
      "lastIncidentDate=$lastIncidentDate}";
}
