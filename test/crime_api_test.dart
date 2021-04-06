import 'package:crime/crime.dart';
import 'package:crime/src/model/crime_coverage.dart';
import 'package:test/test.dart';

void main() {
  final Crime crime = Crime(apiKey: "k3RAzKN1Ag14xTPlculT39RZb38LGgsG8n27ZycG");

  group('crime api unit tests', () {
    test(
        'it should return a list with crime in cities when requested crime coverage',
        () async {
      try {
        final List<CrimeCoverage> crimeCoverage =
            await crime.getCrimeCoverageData();

        expect(crimeCoverage.length, 255);
      } catch (e) {
        expect(e, isNull);
      }
    });

    test(
        'it should return 696538 when getCrimeIncidents() gets called with specific parameters',
        () async {
      try {
        final CrimeIncidents result = await crime.getCrimeIncidents(
          37.773972,
          -122.431297,
          "50mi",
          DateTime(2019, 1, 1),
          DateTime(2021, 2, 7),
        );

        expect(result.totalIncidents, 696538);
      } catch (e) {
        expect(e, isNull);
        ;
      }
    });

    test(
        'it should return 696538 when getCrowdsourcedCrimeIncidents() gets called with specific parameters',
        () async {
      try {
        final CrimeIncidents result = await crime.getCrowdsourcedCrimeIncidents(
          37.773972,
          -122.431297,
          "50mi",
          DateTime(2019, 1, 1),
          DateTime(2021, 2, 7),
        );

        expect(result.totalIncidents, 696538);
      } catch (e) {
        expect(e, isNull);
      }
    });

    test(
        'It should return 696538 when getCrimeStats() gets called with specific parameters',
        () async {
      try {
        final CrimeStats crimeStats = await crime.getCrimeStats(37.773972,
            -122.431297, "50mi", DateTime(2019, 1, 1), DateTime(2021, 2, 7));

        expect(crimeStats.totalIncidents, 696538);
      } catch (e) {
        expect(e, isNull);
      }
    });
  });
}
