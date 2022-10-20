import 'package:weather/extension/list_ext.dart';

enum WeatherType {
  clear("Clear", "ic_clear.png"),
  sunny("Sunny", "ic_sunny.png"),
  partlyCloudy("Partly cloudy", "ic_partly_cloudy.png"),
  cloudy("Cloudy", "ic_cloudy.png"),
  overcast("Overcast", "ic_overcast.png"),
  mist("Mist", "ic_mist.png"),
  patchyRainPossible("Patchy rain possible", "ic_patchy_rain_possible.png"),
  patchySnowPossible("Patchy snow possible", "ic_patchy_snow_possible.png"),
  patchySleetPossible("Patchy sleet possible", "ic_patchy_sleet_possible.png"),
  patchyFreezingDrizzlePossible("Patchy freezing drizzle possible",
      "ic_patchy_freezing_drizzle_possible.png"),
  thunderyOutbreaksPossible(
      "Thundery outbreaks possible", " ic_thundery_outbreaks_possible.png"),
  blowingSnow("Blowing snow", "ic_blowing_snow_1.png"),
  blizzard("Blizzard", "ic_blizzard.png"),
  fog("Fog", "ic_fog"),
  freezingFog("Freezing fog", "ic_freezing_fog.png"),
  patchyLightDrizzle("Patchy light drizzle", "ic_patchy_light_drizzle.png"),
  lightDrizzle("Light drizzle", "ic_light_drizzle.png"),
  freezingDrizzle("Freezing drizzle", "ic_freezing_drizzle.png"),
  heavyFreezingDrizzle(
      "Heavy freezing drizzle", "ic_heavy_freezing_drizzle.png"),
  patchyLightRain("Patchy light rain", "ic_patchy_light_rain.png"),
  lightRain("Light rain", "ic_light_rain.png"),
  moderateRainAtTimes("Moderate rain at times", "ic_light_rain.png"),
  moderateRain("Moderate rain", "ic_light_rain.png"),
  heavyRainAtTimes("Heavy rain at times", "ic_light_rain.png"),
  heavyRain("Heavy rain", "ic_light_rain.png"),
  lightFreezingRain("Light freezing rain", "ic_light_rain.png"),
  moderateOrHeavyFreezingRain(
      "Moderate or heavy freezing rain", "ic_light_rain.png"),
  lightSleet("Light sleet", "ic_sleet.png"),
  moderateOrHeavySleet("Moderate or heavy sleet", "ic_sleet.png"),
  patchyLightSnow("Patchy light snow", "ic_patchy_light_snow.png"),
  lightSnow("Light snow", "ic_light_snow.png"),
  patchyModerateSnow("Patchy moderate snow", "ic_moderate_snow.png"),
  moderateSnow("Moderate snow", "ic_moderate_snow.png"),
  patchyHeavySnow("Patchy heavy snow", "ic_patchy_heavy_snow.png"),
  heavySnow("Heavy snow", "ic_heavy_snow.png"),
  icePellets("Ice pellets", "ic_ice_pellets.png"),
  lightRainShower("Light rain shower", "ic_shower.png"),
  moderateOrHeavyRainShower("Moderate or heavy rain shower", "ic_shower.png"),
  torrentialRainShower("Torrential rain shower", "ic_shower.png"),
  lightSleetShowers("Light sleet showers", "ic_shower.png"),
  moderateOrHeavySleetShowers(
      "Moderate or heavy sleet showers", "ic_shower.png"),
  lightSnowShowers("Light snow showers", "ic_sleet.png"),
  moderateOrHeavySnowShowers("Moderate or heavy snow showers", "ic_sleet.png"),
  patchyLightRainWithThunder("Patchy light rain with thunder",
      "ic_patchy_light_snow_with_thunder.png"),
  moderateOrHeavyRainWithThunder(
      "Moderate or heavy rain with thunder", "ic_thunderstorm.png"),
  patchyLightSnowWithThunder(
      "Patchy light snow with thunder", "ic_snow_with_thunder.png"),
  moderateOrHeavySnowWithThunder(
      "Moderate or heavy snow with thunder", "ic_snow_with_thunder.png");

  const WeatherType(this.value, this.iconPath);

  final String value;
  final String iconPath;

  static WeatherType fromDescription(String description) {
    return values.find((element) => element.value == description) ??
        WeatherType.cloudy;
  }
}
