import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
          builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
                builder: (context, state) {
                  return MaterialApp(
                    theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        backgroundColor: getThemeColor(
                          BlocProvider.of<GetWeatherCubit>(context)
                              .weatherModel
                              ?.weatherCondition,
                        ),
                      ),
                    ),
                    debugShowCheckedModeBanner: false,
                    home: const HomeView(),
                  );
                },
              )),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    // Clear and Sunny
    case 'Sunny':
    case 'Clear':
      return Colors.orange;

    // Cloudy conditions
    case 'Partly cloudy':
    case 'Cloudy':
    case 'Overcast':
      return Colors.grey;

    // Mist and Fog
    case 'Mist':
    case 'Fog':
    case 'Freezing fog':
      return Colors.blueGrey;

    // Rain conditions
    case 'Patchy rain possible':
    case 'Light rain':
    case 'Moderate rain at times':
    case 'Moderate rain':
    case 'Heavy rain':
    case 'Heavy rain at times':
    case 'Light freezing rain':
    case 'Moderate or heavy freezing rain':
    case 'Light rain shower':
    case 'Moderate or heavy rain shower':
      return Colors.lightBlue;

    // Sleet and Drizzle
    case 'Patchy light drizzle':
    case 'Light drizzle':
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
    case 'Light sleet':
    case 'Moderate or heavy sleet':
      return Colors.blueGrey;

    // Snow conditions
    case 'Patchy snow possible':
    case 'Light snow':
    case 'Patchy light snow':
    case 'Moderate snow':
    case 'Heavy snow':
    case 'Blizzard':
      return Colors.blue;

    // Thunderstorms
    case 'Thundery outbreaks possible':
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
      return Colors.deepPurple;

    // Other conditions
    case 'Ice pellets':
      return Colors.cyan;
    case 'Blowing snow':
      return Colors.lightBlue;
    default:
      return Colors.grey; // Default for unknown conditions
  }
}
