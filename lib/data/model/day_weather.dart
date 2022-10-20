import 'package:weather/data/model/models.dart';
import 'package:weather/extension/list_ext.dart';

import '../../common/common.dart';

class DayWeather {
  String title = "";

  String maxTemperateC = "";
  String minTemperateC = "";
  String description = "";

  List<Hourly> hourlyWeathers = List.empty();

  DayWeather(Weather weather) {
    final currentDay = DateTime.now().day;
    if (weather.dateTime.day == currentDay) {
      title = "Today";
    } else if (weather.dateTime.day == currentDay + 1) {
      title = "Tomorrow";
    } else {
      title = weather.dateTime.weekday == DateTime.monday
          ? "Monday"
          : weather.dateTime.weekday == DateTime.tuesday
              ? "Tuesday"
              : weather.dateTime.weekday == DateTime.wednesday
                  ? "Wednesday"
                  : weather.dateTime.weekday == DateTime.thursday
                      ? "Thursday"
                      : weather.dateTime.weekday == DateTime.friday
                          ? "Friday"
                          : weather.dateTime.weekday == DateTime.saturday
                              ? "Saturday"
                              : weather.dateTime.weekday == DateTime.sunday
                                  ? "Sunday"
                                  : "";
    }

    maxTemperateC = weather.maxtempC;
    minTemperateC = weather.mintempC;
    description = weather.hourlyWeathers
            .groupBy((e) => (e.weatherDesc.firstOrNull()?.value ?? ""))
            .toList()
            .map((e) => Pair(e.first, e.second.length))
            .maxByOrNull((element) => element.second)
            ?.first ??
        "";
  }
}
