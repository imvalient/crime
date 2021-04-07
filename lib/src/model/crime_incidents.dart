import 'crime_raw_crowd_data.dart';

import 'crime_raw_data.dart';

class CrimeIncidents {
  /// Total number of incidents.
  final int? totalIncidents;

  /// Total number of pages for the request
  final int? totalPages;

  const CrimeIncidents({this.totalIncidents, this.totalPages});
}

class CrimeRawIncidents extends CrimeIncidents {
  /// List of incidents.
  final List<CrimeRawData>? incidents;

  const CrimeRawIncidents(
      {int? totalIncidents, int? totalPages, this.incidents})
      : super(totalIncidents: totalIncidents, totalPages: totalPages);

  factory CrimeRawIncidents.fromJson(Map<String, dynamic> crimeIncidents) =>
      CrimeRawIncidents(
          totalIncidents: crimeIncidents['total_incidents'],
          totalPages: crimeIncidents['total_pages'],
          incidents: (crimeIncidents['incidents'] as List)
              .map((incidents) => CrimeRawData.fromJson(incidents))
              .toList());

  @override
  String toString() =>
      "[CrimeRawIncidents]: {totalIncidents=${super.totalIncidents}, totalPages=${super.totalPages}, incidents=${incidents}}";
}

class CrimeCrowdIncidents extends CrimeIncidents {
  final List<CrimeRawCrowdData>? incidents;

  const CrimeCrowdIncidents(
      {int? totalIncidents, int? totalPages, this.incidents})
      : super(totalIncidents: totalIncidents, totalPages: totalPages);

  factory CrimeCrowdIncidents.fromJson(Map<String, dynamic> crimeIncidents) =>
      CrimeCrowdIncidents(
          totalIncidents: crimeIncidents['total_incidents'],
          totalPages: crimeIncidents['total_pages'],
          incidents: (crimeIncidents['incidents'] as List)
              .map((incidents) => CrimeRawCrowdData.fromJson(incidents))
              .toList());

  @override
  String toString() =>
      "[CrimeRawIncidents]: {totalIncidents=${super.totalIncidents}, totalPages=${super.totalPages}, incidents=${incidents}}";
}
