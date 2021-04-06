import 'package:crime/crime.dart';
import 'package:crime/src/exception/crime_exception.dart';
import 'package:crime/src/utils/format_datetime.dart';
import 'package:crime/src/service/crime_client.dart' as crimeClient;

import 'package:test/test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'crime_static_mock.dart';
import 'crime_client_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('crime client unit tests', () {
    test(
        'It should return 255 when Mocked getCrimeCoverageData() length gets called',
        () async {
      final client = MockClient();
      final Uri uri =
          Uri.https('api.crimeometer.com', '/v1/incidents/raw-data-coverage');

      when(client.get(uri,
              headers: {"Content-Type": "application/json", "x-api-key": ''}))
          .thenAnswer((_) async => http.Response(rawDataCoverage, 200));

      crimeClient.CrimeClientImpl crimeClientImpl =
          crimeClient.CrimeClientImpl();

      final List<CrimeCoverage> result =
          await crimeClientImpl.getCrimeCoverageData('', client);

      expect(result.length, 255);
    });

    test(
        'it should return 696538 when mocked getCrimeIncidents() with specific parameters',
        () async {
      try {
        final client = MockClient();

        final Uri uri =
            Uri.https('api.crimeometer.com', '/v1/incidents/raw-data', {
          'lat': '37.773972',
          'lon': '-122.431297',
          'distance': '50mi',
          'datetime_ini': formatDateTime(DateTime(2019, 1, 1)).toString(),
          'datetime_end': formatDateTime(DateTime(2021, 2, 7)).toString(),
          'page': '1'
        });

        when(client.get(uri,
                headers: {"Content-Type": "application/json", "x-api-key": ''}))
            .thenAnswer((_) async => http.Response(rawDataIncidents, 200));

        crimeClient.CrimeClientImpl crimeClientImpl =
            crimeClient.CrimeClientImpl();

        final CrimeIncidents result = await crimeClientImpl.getCrimeIncidents(
            37.773972,
            -122.431297,
            "50mi",
            DateTime(2019, 1, 1),
            DateTime(2021, 2, 7),
            1,
            '',
            client);

        expect(result.totalIncidents, 696538);
      } catch (e) {
        print(e);
      }
    });

    test(
        'it should return 696538 when mocked getCrowdsourcedCrimeIncidents() with specific parameters',
        () async {
      try {
        final client = MockClient();

        final Uri uri = Uri.https(
            'api.crimeometer.com', '/v1/incidents/crowdsourced-raw-data', {
          'lat': '37.773972',
          'lon': '-122.431297',
          'distance': '50mi',
          'datetime_ini': formatDateTime(DateTime(2019, 1, 1)).toString(),
          'datetime_end': formatDateTime(DateTime(2021, 2, 7)).toString(),
          'page': '1'
        });

        when(client.get(uri,
                headers: {"Content-Type": "application/json", "x-api-key": ''}))
            .thenAnswer((_) async => http.Response(rawDataIncidents, 200));

        crimeClient.CrimeClientImpl crimeClientImpl =
            crimeClient.CrimeClientImpl();

        final CrimeIncidents result =
            await crimeClientImpl.getCrowdsourcedCrimeIncidents(
                37.773972,
                -122.431297,
                "50mi",
                DateTime(2019, 1, 1),
                DateTime(2021, 2, 7),
                1,
                '',
                client);

        expect(result.totalIncidents, 696538);
      } catch (e) {
        print(e);
      }
    });

    test(
        'It should return 696538 when mocked getCrimeStats() with specific parameters',
        () async {
      try {
        final client = MockClient();

        final Uri uri =
            Uri.https('api.crimeometer.com', '/v1/incidents/stats', {
          'lat': '37.773972',
          'lon': '-122.431297',
          'distance': '50mi',
          'datetime_ini': formatDateTime(DateTime(2019, 1, 1)).toString(),
          'datetime_end': formatDateTime(DateTime(2021, 2, 7)).toString(),
          'source': '1'
        });

        when(client.get(uri,
                headers: {"Content-Type": "application/json", "x-api-key": ''}))
            .thenAnswer((_) async => http.Response(crimeStatsData, 200));

        crimeClient.CrimeClientImpl crimeClientImpl =
            crimeClient.CrimeClientImpl();

        final CrimeStats crimeStats = await crimeClientImpl.getCrimeStats(
            37.773972,
            -122.431297,
            "50mi",
            DateTime(2019, 1, 1),
            DateTime(2021, 2, 7),
            1,
            '',
            client);

        expect(crimeStats.totalIncidents, 696538);
      } catch (e) {
        print(e);
      }
    });

    test(
        'It should return ForbiddenRequestException when Mocked getCrimeCoverageData() length gets called',
        () async {
      final client = MockClient();
      final Uri uri =
          Uri.https('api.crimeometer.com', '/v1/incidents/raw-data-coverage');

      when(client.get(uri,
              headers: {"Content-Type": "application/json", "x-api-key": ''}))
          .thenAnswer((_) async => http.Response(forbiddenMessage, 403));

      crimeClient.CrimeClientImpl crimeClientImpl =
          crimeClient.CrimeClientImpl();
      try {
        await crimeClientImpl.getCrimeCoverageData('', client);
      } catch (e) {
        expect(e, isA<ForbiddenRequestException>());
      }
    });

    test(
        'It should return LimitExceededRequestException when Mocked getCrimeCoverageData() length gets called',
        () async {
      final client = MockClient();
      final Uri uri =
          Uri.https('api.crimeometer.com', '/v1/incidents/raw-data-coverage');

      when(client.get(uri,
              headers: {"Content-Type": "application/json", "x-api-key": ''}))
          .thenAnswer((_) async => http.Response(apiKeyLimitExceed, 429));

      crimeClient.CrimeClientImpl crimeClientImpl =
          crimeClient.CrimeClientImpl();
      try {
        await crimeClientImpl.getCrimeCoverageData('', client);
      } catch (e) {
        expect(e, isA<LimitExceededRequestException>());
      }
    });
  });
}
