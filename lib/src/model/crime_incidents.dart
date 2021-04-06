import 'crime_raw_data.dart';

class CrimeIncidents {
  /// Total number of incidents.
  final int? totalIncidents;

  /// Total number of pages for the request
  final int? totalPages;

  /// List of incidents.
  final List<CrimeRawData>? incidents;

  const CrimeIncidents({this.totalIncidents, this.totalPages, this.incidents});

  factory CrimeIncidents.fromJson(Map<String, dynamic> crimeIncidents) =>
      CrimeIncidents(
          totalIncidents: crimeIncidents['total_incidents'],
          totalPages: crimeIncidents['total_pages'],
          incidents: (crimeIncidents['incidents'] as List)
              .map((incidents) => CrimeRawData.fromJson(incidents))
              .toList());

  @override
  String toString() =>
      "[CrimeIncidents]: {totalIncidents=${totalIncidents}, totalPages=${totalPages}, incidents=${incidents}}";
}
