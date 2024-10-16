class UIImages {
  static String bg_1 = "assets/images/bg_1.png";

  static String compass = "assets/images/compass.png";
  static String closedUmbrella = "assets/images/closed_umbrella.png";
  static String umbrellaWithRainDrops = "assets/images/umbrella_with_rain_drops.png";
  static String comet = "assets/images/comet.png";
  static String cloudWithLightningAndRain = "assets/images/cloud_with_lightning_and_rain.png";
  static String cloudWithLightning = "assets/images/cloud_with_lightning.png";
  static String cloudWithRain = "assets/images/cloud_with_rain.png";
  static String cyclone = "assets/images/cyclone.png";
  static String cloud = "assets/images/cloud.png";
  static String snowAndCloud = "assets/images/snow_and_cloud.png";
  static String snowman = "assets/images/snowman.png";
  static String sun = "assets/images/sun.png";
  static String sunBehindCloud = "assets/images/sun_behind_cloud.png";
  static String sunBehindLargeCloud = "assets/images/sun_behind_large_cloud.png";
  static String sunBehindRainCloud = "assets/images/sun_behind_rain_cloud.png";
  static String sunBehindSmallCloud = "assets/images/sun_behind_small_cloud.png";
  static String sunWithHappyFace = "assets/images/sun_with_happy_face.png";
  static String tornado = "assets/images/tornado.png";
  static String fog = "assets/images/fog.png";
  static String foggy = "assets/images/foggy.png";
  static String volcano = "assets/images/volcano.png";
  static String windFace = "assets/images/wind_face.png";
  static String humidity = "assets/images/humidity.png";
  static String errorIcon = "assets/images/error_icon.png";
  static String peekingEyeEmoji = "assets/images/peeking_eye_emoji.png";

  static String getWeatherIcon(int id) {
    switch (id) {
      // Thunderstorm with rain
      case 200:
      case 201:
      case 202:
        return cloudWithLightningAndRain;

      // Thunderstorm without rain
      case 210:
      case 211:
      case 212:
      case 221:
      case 230:
      case 231:
      case 232:
        return cloudWithLightning;

      // Drizzle conditions
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return umbrellaWithRainDrops;

      // Light to moderate rain
      case 500:
      case 501:
        return cloudWithRain;

      // Heavy rain
      case 502:
      case 503:
      case 504:
        return closedUmbrella;

      // Shower rain
      case 520:
      case 521:
      case 522:
      case 531:
        return umbrellaWithRainDrops;

      // Freezing rain
      case 511:
        return snowAndCloud;

      // Snow
      case 600:
      case 601:
      case 602:
        return snowman;

      // Snow showers
      case 620:
      case 621:
      case 622:
        return snowAndCloud;

      // Sleet and rain-snow mix
      case 611:
      case 612:
      case 613:
      case 615:
      case 616:
        return snowAndCloud;

      // Mist
      case 701:
        return fog;

      // Smoke
      case 711:
        return cyclone;

      // Haze
      case 721:
        return foggy;

      // Sand/Dust, wind-related conditions
      case 731:
      case 751:
      case 761:
        return windFace;

      // Fog
      case 741:
        return foggy;

      // Volcanic ash
      case 762:
        return volcano;

      // Squalls
      case 771:
        return cloudWithRain;

      // Tornado
      case 781:
        return tornado;

      // Clear sky
      case 800:
        return sun;

      // Few clouds
      case 801:
        return sunBehindSmallCloud;

      // Scattered clouds
      case 802:
        return sunBehindCloud;

      // Broken clouds
      case 803:
        return sunBehindLargeCloud;

      // Overcast clouds
      case 804:
        return cloud;

      // Default icon
      default:
        return sunWithHappyFace;
    }
  }
}
