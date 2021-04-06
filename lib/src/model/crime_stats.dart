import '../utils/try_parse.dart';

class CrimeStats {
  /// Total number of incidents.
  final int? totalIncidents;

  /// Incident offenses.
  final List<CrimeReportType>? reportTypes;

  const CrimeStats({this.totalIncidents, this.reportTypes});

  factory CrimeStats.fromJson(Map<String, dynamic> crimeStats) => CrimeStats(
      totalIncidents: crimeStats['total_incidents'],
      reportTypes: (crimeStats['report_types'] as List)
          .map((reports) => CrimeReportType.fromJson(reports))
          .toList());

  @override
  String toString() =>
      "[CrimeStats]: {totalIncidents=$totalIncidents, reportTypes=[$reportTypes]}";
}

class CrimeReportType {
  /// Incident offense description
  final String? type;

  /// Total number of incidents by offense description.
  final int? count;
  final double? csi;

  const CrimeReportType({this.type, this.count, this.csi});

  factory CrimeReportType.fromJson(Map<String, dynamic> crimeReportType) {
    return CrimeReportType(
        type: tryParse(crimeReportType['type']),
        count: crimeReportType['count'],
        csi: double.tryParse(
            crimeReportType['csi'] is String ? crimeReportType['csi'] : '0'));
  }

  @override
  String toString() =>
      "[CrimeReportType]: {type=$type, count=$count, csi=$csi}";
}
