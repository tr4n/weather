import 'package:weather/extension/list_ext.dart';

enum WeatherType {
  clear("Clear", "ic_clear.png", "ic_clear_night.png", "image_clear_light.png",
      "image_sunny_light.png"),
  sunny("Sunny", "ic_sunny.png", "ic_sunny_night.png", "image_sunny_light.png",
      "image_sunny_night.png"),
  partlyCloudy("Partly cloudy", "ic_partly_cloudy.png", "ic_partly_cloudy.png",
      "image_cloud.png", "image_cloud.png"),
  cloudy("Cloudy", "ic_cloudy.png", "ic_cloudy.png", "image_cloud.png",
      "image_cloud.png"),
  overcast("Overcast", "ic_overcast.png", "ic_overcast.png", "image_cloud.png",
      "image_cloud.png"),
  mist("Mist", "ic_mist.png", "ic_mist.png", "image_cloud.png",
      "image_cloud.png"),
  patchyRainPossible(
      "Patchy rain possible",
      "ic_patchy_rain_possible.png",
      "ic_patchy_rain_possible_night.png",
      "image_sunny_cloudy_rainy_light.png",
      "image_sunny_cloudy_rainy_night.png"),
  patchySnowPossible("Patchy snow possible", "ic_patchy_snow_possible.png",
      "ic_patchy_snow_possible_night.png", "image_snow.png", "image_snow.png"),
  patchySleetPossible(
      "Patchy sleet possible",
      "ic_patchy_sleet_possible.png",
      "ic_patchy_sleet_possible_night.png",
      "image_sleet.png",
      "image_sleet.png"),
  patchyFreezingDrizzlePossible(
      "Patchy freezing drizzle possible",
      "ic_patchy_freezing_drizzle_possible.png",
      "ic_patchy_freezing_drizzle_possible_night.png",
      "image_sunny_cloudy_rainy_light.png",
      "image_sunny_cloudy_rainy_night.png"),
  thunderyOutbreaksPossible(
      "Thundery outbreaks possible",
      "ic_thundery_outbreaks_possible.png",
      "ic_thundery_outbreaks_possible_night.png",
      "image_thunderstorm.png",
      "image_thunderstorm.png"),
  blowingSnow("Blowing snow", "ic_blowing_snow.png", "ic_blowing_snow.png",
      "image_wind_snow.png", "image_wind_snow.png"),
  blizzard("Blizzard", "ic_blizzard.png", "ic_blizzard.png", "image_snow.png",
      "image_snow.png"),
  fog("Fog", "ic_fog", "ic_fog", "image_foggy.png", "image_foggy.png"),
  freezingFog("Freezing fog", "ic_freezing_fog.png", "ic_freezing_fog.png",
      "image_foggy.png", "image_foggy.png"),
  patchyLightDrizzle("Patchy light drizzle", "ic_patchy_light_drizzle.png",
      "ic_patchy_rain_possible_night.png", "image_rain.png", "image_rain.png"),
  lightDrizzle("Light drizzle", "ic_light_drizzle.png", "ic_light_drizzle.png",
      "image_rain.png", "image_rain.png"),
  freezingDrizzle("Freezing drizzle", "ic_freezing_drizzle.png",
      "ic_freezing_drizzle.png", "image_rain.png", "image_rain.png"),
  heavyFreezingDrizzle(
      "Heavy freezing drizzle",
      "ic_heavy_freezing_drizzle.png",
      "ic_heavy_freezing_drizzle.png",
      "image_rain.png",
      "image_rain.png"),
  patchyLightRain(
      "Patchy light rain",
      "ic_patchy_light_rain.png",
      "ic_heavy_freezing_drizzle_night.png",
      "image_sunny_cloudy_rainy_light.png",
      "image_sunny_cloudy_rainy_night.png"),
  lightRain("Light rain", "ic_light_rain.png", "ic_light_rain.png",
      "image_rain.png", "image_rain.png"),
  moderateRainAtTimes("Moderate rain at times", "ic_light_rain.png",
      "ic_light_rain.png", "image_rain.png", "image_rain.png"),
  moderateRain("Moderate rain", "ic_light_rain.png", "ic_light_rain.png",
      "image_rain.png", "image_rain.png"),
  heavyRainAtTimes("Heavy rain at times", "ic_light_rain.png",
      "ic_light_rain.png", "image_rain.png", "image_rain.png"),
  heavyRain("Heavy rain", "ic_light_rain.png", "ic_light_rain.png",
      "image_rain.png", "image_rain.png"),
  lightFreezingRain("Light freezing rain", "ic_light_rain.png",
      "ic_light_rain.png", "image_rain.png", "image_rain.png"),
  moderateOrHeavyFreezingRain(
      "Moderate or heavy freezing rain",
      "ic_light_rain.png",
      "ic_light_rain.png",
      "image_rain.png",
      "image_rain.png"),
  lightSleet("Light sleet", "ic_sleet.png", "ic_sleet.png", "image_sleet.png",
      "image_sleet.png"),
  moderateOrHeavySleet("Moderate or heavy sleet", "ic_sleet.png",
      "ic_sleet.png", "image_sleet.png", "image_sleet.png"),
  patchyLightSnow("Patchy light snow", "ic_patchy_light_snow.png",
      "ic_patchy_snow_possible_night.png", "image_snow.png", "image_snow.png"),
  lightSnow("Light snow", "ic_light_snow.png", "ic_light_snow.png",
      "image_snow.png", "image_snow.png"),
  patchyModerateSnow("Patchy moderate snow", "ic_moderate_snow.png",
      "ic_moderate_snow.png", "image_snow.png", "image_snow.png"),
  moderateSnow("Moderate snow", "ic_moderate_snow.png", "ic_moderate_snow.png",
      "image_snow.png", "image_snow.png"),
  patchyHeavySnow("Patchy heavy snow", "ic_patchy_heavy_snow.png",
      "ic_patchy_heavy_snow_night.png", "image_snow.png", "image_snow.png"),
  heavySnow("Heavy snow", "ic_heavy_snow.png", "ic_heavy_snow.png",
      "image_snow.png", "image_snow.png"),
  icePellets("Ice pellets", "ic_ice_pellets.png", "ic_ice_pellets.png",
      "image_sleet.png", "image_sleet.png"),
  lightRainShower("Light rain shower", "ic_shower.png", "ic_shower.png",
      "image_rain.png", "image_rain.png"),
  moderateOrHeavyRainShower("Moderate or heavy rain shower", "ic_shower.png",
      "ic_shower.png", "image_rain.png", "image_rain.png"),
  torrentialRainShower("Torrential rain shower", "ic_shower.png",
      "ic_shower.png", "image_rain.png", "image_rain.png"),
  lightSleetShowers("Light sleet showers", "ic_shower.png", "ic_shower.png",
      "image_rain.png", "image_rain.png"),
  moderateOrHeavySleetShowers("Moderate or heavy sleet showers",
      "ic_shower.png", "ic_shower.png", "image_rain.png", "image_rain.png"),
  lightSnowShowers("Light snow showers", "ic_sleet.png", "ic_sleet.png",
      "image_snow.png", "image_snow.png"),
  moderateOrHeavySnowShowers("Moderate or heavy snow showers", "ic_sleet.png",
      "ic_sleet.png", "image_snow.png", "image_snow.png"),
  patchyLightRainWithThunder(
      "Patchy light rain with thunder",
      "ic_patchy_light_snow_with_thunder.png",
      "ic_patchy_light_snow_with_thunder_night.png",
      "image_heavy_rain_and_storm.png",
      "image_heavy_rain_and_storm.png"),
  moderateOrHeavyRainWithThunder(
      "Moderate or heavy rain with thunder",
      "ic_thunderstorm.png",
      "ic_thunderstorm.png",
      "image_heavy_rain_and_storm.png",
      "image_heavy_rain_and_storm.png"),
  patchyLightSnowWithThunder(
      "Patchy light snow with thunder",
      "ic_snow_with_thunder.png",
      "ic_snow_with_thunder.png",
      "image_snow.png",
      "image_snow.png"),
  moderateOrHeavySnowWithThunder(
      "Moderate or heavy snow with thunder",
      "ic_snow_with_thunder.png",
      "ic_snow_with_thunder.png",
      "image_snow.png",
      "image_snow.png");

  const WeatherType(this.value, this._iconLight, this._iconNight,
      this._imageLight, this._imageNight);

  final String value;
  final String _iconLight;
  final String _iconNight;
  final String _imageLight;
  final String _imageNight;

  String getIconPath(num hour) {
    return (hour >= 18 || hour < 6) ? "assets/icons/$_iconNight" : "assets/icons/$_iconLight";
  }

  String getImagePath(num hour) {
    return (hour >= 18 || hour < 6)
        ? "assets/images/$_imageNight"
        : "assets/images/$_imageLight";
  }

  static WeatherType fromDescription(String description) {
    return values.find((element) => element.value == description) ??
        WeatherType.cloudy;
  }
}
