/// Package to make Crime data requests, this api lets you retrieve crime information from 30+ cities across the US and LATAM.
/// The api exposes four methods to retrieve raw crime date, crime statistics, crime coverage information and crime crowsourced data.
///
/// It's an implementation of the methods from the following known Crime data API provider crimeometer.com.
///
/// It has a FREE api key for testing purposes that can be found in the previous link, contact the API Provider to get more information about unlimited requests and it prices.
library crime;

export 'src/crime.dart';
export 'src/model/crime_coverage.dart';
export 'src/model/crime_incidents.dart';
export 'src/model/crime_raw_data.dart';
export 'src/model/crime_stats.dart';
