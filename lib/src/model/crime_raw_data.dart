import '../utils/try_parse.dart';

class CrimeRawData {
  /// City code in UN/LOCODE standard.
  final String? cityKey;

  /// Incident code provided by the source.
  final String? incidentCode;

  /// Incident occurred date (approximate in some cases).
  final DateTime? incidentDate;

  /// Incident offense type using FBI-NIBRS standard.
  final String? incidentOffense;

  /// Incident offense code using FBI-NIBRS standard.
  final String? incidentOffenseCode;

  /// Incident offense sub type using FBI-NIBRS standard.
  final String? incidentOffenseDescription;

  /// Incident detail description.
  final String? incidentOffenseDetailDescription;

  /// Incident against Person/Property/Society/Not a Crime.
  final String? incidentOffenseCrimeAgainst;

  /// Incident action status (Commited/Attempted).
  final String? incidentOffenseAction;

  /// Type of incident from the original source.
  final String? incidentSourceOriginalType;

  /// Incident source name.
  final String? incidentSourceName;

  /// Incident Latitude
  final double? incidentLatitude;

  /// Incident Longitude.
  final double? incidentLongitude;

  /// Incident address (approximate in some cases).
  final String? incidentAddress;

  const CrimeRawData(
      {this.cityKey,
      this.incidentCode,
      this.incidentDate,
      this.incidentOffense,
      this.incidentOffenseCode,
      this.incidentOffenseDescription,
      this.incidentOffenseDetailDescription,
      this.incidentOffenseCrimeAgainst,
      this.incidentOffenseAction,
      this.incidentSourceOriginalType,
      this.incidentSourceName,
      this.incidentLatitude,
      this.incidentLongitude,
      this.incidentAddress});

  factory CrimeRawData.fromJson(Map<String, dynamic> crimeRawData) =>
      CrimeRawData(
          cityKey: tryParse(crimeRawData['city_key']),
          incidentCode: tryParse(crimeRawData['incident_code']),
          incidentDate: DateTime.tryParse(crimeRawData['incident_date']),
          incidentOffense: tryParse(crimeRawData['incident_offense']),
          incidentOffenseCode: tryParse(crimeRawData['incident_offense_code']),
          incidentOffenseDescription:
              tryParse(crimeRawData['incident_offense_description']),
          incidentOffenseDetailDescription:
              tryParse(crimeRawData['incident_offense_detail_description']),
          incidentOffenseCrimeAgainst:
              tryParse(crimeRawData['incident_offense_crime_against']),
          incidentOffenseAction:
              tryParse(crimeRawData['incident_offense_action']),
          incidentSourceOriginalType:
              tryParse(crimeRawData['incident_source_original_type']),
          incidentSourceName: tryParse(crimeRawData['incident_source_name']),
          incidentLatitude: crimeRawData['incident_latitude'],
          incidentLongitude: crimeRawData['incident_longitude'],
          incidentAddress: tryParse(crimeRawData['incident_address']));

  @override
  String toString() =>
      "[CrimeRawData]: {cityKey=$cityKey, incidentCode=$incidentCode, incidentDate=$incidentDate, incidentOffense=$incidentOffense, incidentOffenseCode=$incidentOffenseCode, " +
      "incidentOffenseDescription=$incidentOffenseDescription, incidentOffenseDetailDescription=$incidentOffenseDetailDescription, incidentOffenseCrimeAgainst=$incidentOffenseCrimeAgainst, " +
      "incidentOffenseAction=$incidentOffenseAction, incidentSourceOriginalType=$incidentSourceOriginalType, incidentSourceName=$incidentSourceName, incidentLatitude=$incidentLatitude, incidentLongitude=$incidentLongitude, " +
      "incidentAddress=$incidentAddress}";
}
