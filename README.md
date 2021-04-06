# Crime library

![workflow name](https://github.com/imvalient/crime/workflows/Dart%20CI/badge.svg)
[![likes](https://badges.bar/crime/likes)](https://pub.dev/packages/crime/score)
[![popularity](https://badges.bar/crime/popularity)](https://pub.dev/packages/geocode/score)
[![pub points](https://badges.bar/crime/pub%20points)](https://pub.dev/packages/crime/score)

## Introduction

Package to make Crime data requests, this API lets you retrieve crime information from 30+ cities across the US and LATAM. The API exposes four methods to retrieve raw crime date, crime statistics, crime coverage information, and crowdsourced crime data.

It's implementing the methods from the following known Crime data API provider [crimeometer.com](https://www.crimeometer.com/crime-data-api-documentation).

It has a FREE API key for testing purposes that can be found in the previous link. Contact the API provider to get more information about unlimited requests and their prices.

## Installation

```yaml
dependencies:
  crime: 0.1.0
```

## Example

See `example/main.dart`

```dart
import 'package:crime/crime.dart';

void main() async {
  try {
    const String API_KEY = "XXXXXXXXXXXXXXX"; // Your private API Key.

    final Crime crime = Crime(apiKey: API_KEY);

    final CrimeIncidents crimeIncidents = await crime.getCrimeIncidents(
      37.773972,
      -122.431297,
      "50mi",
      DateTime(2021, 1, 1),
      DateTime(2021, 2, 7),
    );

    crimeIncidents.incidents?.forEach((CrimeRawData crimeData) {
      print(
          "Crime incident [${crimeData.incidentOffense}] at [${crimeData.cityKey}]");
    });
  } catch (e) {
    print(e);
  }
}
```

## Methods

### Constructor

Library `crime` class constructor, includes a mandatory parameter to set the `apiKey`.

```dart
Crime({this.apiKey});
```

### getCrimeCoverageData

Method to fetch crime coverage data from the cities of the U.S, and a few cities in LATAM: Sao Paulo (Brazil), Rio de Janeiro (Brazil), Buenos Aires (Argentina), Santiago (Chile), Montevideo (Uruguay), León (Mexico) and others.

```dart
Future<List<CrimeCoverage>> getCrimeCoverageData();
```

### getCrimeIncidents

A method to obtain crime incident data from a specific location, over a range of distance, and over a period of time.

```dart
Future<CrimeIncidents> getCrimeIncidents(double latitude, double longitude, String distance, DateTime startDateTime, DateTime endDateTime, {int page = 1});
```

### getCrimeStats

Method to fetch crime statistics from a specific location, over a range of distance, and over a period of time.

```dart
Future<CrimeStats> getCrimeStats(double latitude, double longitude, String distance, DateTime startDateTime, DateTime endDateTime, {int source = 1});
```

### getCrowdsourcedCrimeIncidents

A method to obtain unofficial crime incident data from a specific location, over a range of distance, and over a period of time. This information is collected from the community through CityCop app.

```dart
Future<CrimeIncidents> getCrowdsourcedCrimeIncidents(double latitude, double longitude, String distance, DateTime startDateTime, DateTime endDateTime, {int page = 1});
```

## Responses

### CrimeCoverage

| Attribute | Type | Description |
|-----------|------|-------------|
| cityName  | String| The name of the city. |
| incidentsQuantity | int | The amount of incidents. |
| cityKey | String | The key value of the city. |
| firstIncidentDate | DateTime | The date of the first incident. |
| lastIncidentDate | DateTime | The date of the last incident. |

### CrimeIncidents

| Attribute | Type | Description |
|-----------|------|-------------|
| totalIncidents| int | Total number of incidents. |
| totalPages | int | Total number of pages for the request. |
| incidents | List\<[CrimeRawData](####CrimeRawData)\> | List of incidents. |

#### CrimeRawData

| Attribute | Type | Description |
|-----------|------|-------------|
| cityKey | String | City code in UN/LOCODE standard. |
| incidentCode | String | Incident code provided by the source. |
| incidentDate | DateTime | Incident occurred date (aprox.). |
| incidentOffense | String | Incident offense type using FBI-NIBRS standard. |
| incidentOffenseCode | String | Incident offense code using FBI-NIBRS standard. |
| incidentOffenseDescription | String | Incident offense sub type using FBI-NIBRS standard. |
| incidentOffenseDetailDescription | String | Incident detail description. |
| incidentOffenseCrimeAgainst | String | Incident against Person/Property/Society/Not a Crime. |
| incidentOffenseAction | String | Incident action status (Commited/Attempted). |
| incidentSourceOriginalType | String | Type of incident from the original source. |
| incidentSourceName | String | Incident source name. |
| incidentLatitude | double | Incident latitude. |
| incidentLongitude | double | Incident longitude. |
| incidentAddress | String | Incident address (approximate in some cases). |

### CrimeStats

| Attribute | Type | Description |
|-----------|------|-------------|
| totalIncidents | int | Total number of incidents. |
| reportTypes | List\<[CrimeReportType](####CrimeReportType)\>| List of incidents offenses. |

#### CrimeReportType

| Attribute | Type | Description |
|-----------|------|-------------|
| type | String | Incident offense description. |
| count | int | Total number of incidents by offense description. |

## Exceptions

- `MandatoryApiKeyException`: missing mandatory API Key.
- `ForbiddenRequestException`: Forbidden resource, API Key has been deactivated.
- `LimitExceededRequestException`: Too many requests in a short time.

## Dependencies

```yaml
http: ^0.13.1
intl: ^0.17.0
```

## License
[BSD 3-Clause License](LICENSE)