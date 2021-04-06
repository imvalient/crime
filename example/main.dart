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
