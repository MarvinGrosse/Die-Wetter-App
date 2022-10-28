// Mocks generated by Mockito 5.3.2 from annotations
// in die_wetter_app/test/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:convert' as _i11;
import 'dart:typed_data' as _i12;

import 'package:die_wetter_app/models/locations.dart' as _i9;
import 'package:die_wetter_app/models/weather_models/forcast_weather.dart'
    as _i5;
import 'package:die_wetter_app/models/weather_models/today_weather.dart' as _i4;
import 'package:die_wetter_app/services/database_helper.dart' as _i7;
import 'package:die_wetter_app/services/weather_service.dart' as _i10;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;
import 'package:weather/weather.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeather_1 extends _i1.SmartFake implements _i3.Weather {
  _FakeWeather_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeatherFactory_2 extends _i1.SmartFake
    implements _i3.WeatherFactory {
  _FakeWeatherFactory_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTodayWeather_3 extends _i1.SmartFake implements _i4.TodayWeather {
  _FakeTodayWeather_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeForecastWeather_4 extends _i1.SmartFake
    implements _i5.ForecastWeather {
  _FakeForecastWeather_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_5 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_6 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DBHandler].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBHandler extends _i1.Mock implements _i7.DBHandler {
  MockDBHandler() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Database get db => (super.noSuchMethod(
        Invocation.getter(#db),
        returnValue: _FakeDatabase_0(
          this,
          Invocation.getter(#db),
        ),
      ) as _i2.Database);
  @override
  set db(_i2.Database? _db) => super.noSuchMethod(
        Invocation.setter(
          #db,
          _db,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<_i2.Database> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i8.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.getter(#database),
        )),
      ) as _i8.Future<_i2.Database>);
  @override
  _i8.Future<int> insertLocation(_i9.Location? location) => (super.noSuchMethod(
        Invocation.method(
          #insertLocation,
          [location],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);
  @override
  _i8.Future<List<_i9.Location>> getAllLocations() => (super.noSuchMethod(
        Invocation.method(
          #getAllLocations,
          [],
        ),
        returnValue: _i8.Future<List<_i9.Location>>.value(<_i9.Location>[]),
      ) as _i8.Future<List<_i9.Location>>);
  @override
  _i8.Future<int> deleteLocation(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteLocation,
          [id],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);
  @override
  void resetDB() => super.noSuchMethod(
        Invocation.method(
          #resetDB,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [WeatherFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherFactory extends _i1.Mock implements _i3.WeatherFactory {
  MockWeatherFactory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Language get language => (super.noSuchMethod(
        Invocation.getter(#language),
        returnValue: _i3.Language.AFRIKAANS,
      ) as _i3.Language);
  @override
  set language(_i3.Language? _language) => super.noSuchMethod(
        Invocation.setter(
          #language,
          _language,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<_i3.Weather> currentWeatherByLocation(
    double? latitude,
    double? longitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #currentWeatherByLocation,
          [
            latitude,
            longitude,
          ],
        ),
        returnValue: _i8.Future<_i3.Weather>.value(_FakeWeather_1(
          this,
          Invocation.method(
            #currentWeatherByLocation,
            [
              latitude,
              longitude,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Weather>);
  @override
  _i8.Future<_i3.Weather> currentWeatherByCityName(String? cityName) =>
      (super.noSuchMethod(
        Invocation.method(
          #currentWeatherByCityName,
          [cityName],
        ),
        returnValue: _i8.Future<_i3.Weather>.value(_FakeWeather_1(
          this,
          Invocation.method(
            #currentWeatherByCityName,
            [cityName],
          ),
        )),
      ) as _i8.Future<_i3.Weather>);
  @override
  _i8.Future<List<_i3.Weather>> fiveDayForecastByLocation(
    double? latitude,
    double? longitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fiveDayForecastByLocation,
          [
            latitude,
            longitude,
          ],
        ),
        returnValue: _i8.Future<List<_i3.Weather>>.value(<_i3.Weather>[]),
      ) as _i8.Future<List<_i3.Weather>>);
  @override
  _i8.Future<List<_i3.Weather>> fiveDayForecastByCityName(String? cityName) =>
      (super.noSuchMethod(
        Invocation.method(
          #fiveDayForecastByCityName,
          [cityName],
        ),
        returnValue: _i8.Future<List<_i3.Weather>>.value(<_i3.Weather>[]),
      ) as _i8.Future<List<_i3.Weather>>);
}

/// A class which mocks [WeatherService].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherService extends _i1.Mock implements _i10.WeatherService {
  MockWeatherService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.WeatherFactory get wf => (super.noSuchMethod(
        Invocation.getter(#wf),
        returnValue: _FakeWeatherFactory_2(
          this,
          Invocation.getter(#wf),
        ),
      ) as _i3.WeatherFactory);
  @override
  set wf(_i3.WeatherFactory? _wf) => super.noSuchMethod(
        Invocation.setter(
          #wf,
          _wf,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<_i4.TodayWeather> getTodaysWeather(String? cityName) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTodaysWeather,
          [cityName],
        ),
        returnValue: _i8.Future<_i4.TodayWeather>.value(_FakeTodayWeather_3(
          this,
          Invocation.method(
            #getTodaysWeather,
            [cityName],
          ),
        )),
      ) as _i8.Future<_i4.TodayWeather>);
  @override
  _i8.Future<_i5.ForecastWeather> getForcastWeather(String? cityName) =>
      (super.noSuchMethod(
        Invocation.method(
          #getForcastWeather,
          [cityName],
        ),
        returnValue:
            _i8.Future<_i5.ForecastWeather>.value(_FakeForecastWeather_4(
          this,
          Invocation.method(
            #getForcastWeather,
            [cityName],
          ),
        )),
      ) as _i8.Future<_i5.ForecastWeather>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i6.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i11.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i11.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i11.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i11.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_5(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<String>.value(''),
      ) as _i8.Future<String>);
  @override
  _i8.Future<_i12.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i12.Uint8List>.value(_i12.Uint8List(0)),
      ) as _i8.Future<_i12.Uint8List>);
  @override
  _i8.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i8.Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_6(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i8.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
