[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

[![Create release](https://github.com/sofiakb/prayer_times/actions/workflows/create_release.yml/badge.svg)](https://github.com/sofiakb/prayer_times/actions/workflows/create_release.yml)

<!-- PROJECT LOGO -->

<p align="center">
  <img height="100px" src="./assets/images/logo.png">
</p>

<p align="center">

  <h1 align="center">Prayer times</h1>

  <p align="center">
      <!--<a href="https://github.com/sofiakb/prayer_times"><strong>Explore the docs »</strong></a>-->
      <br />
      <br />
      <a href="https://github.com/sofiakb/prayer_times/issues">Report Bug</a>
      ·
      <a href="https://github.com/sofiakb/prayer_times/issues">Request Feature</a>
  </p>

</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About the project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#changelogs">Changelogs</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->

## About The Project

The "prayer_times" Dart package provides accurate Islamic prayer times for various locations worldwide. With flexible configuration options, extensive information, and support for multiple languages, it simplifies the integration of prayer time functionality into Dart and Flutter applications.

### Built With

This section should list any major frameworks that you built your project using. Leave any
add-ons/plugins for the acknowledgements section. Here are a few examples.

* [Dart](https://dart.dev/guides)

<!-- GETTING STARTED -->

### Installation

Add this in pubspec.yaml

```yaml
prayer_times:
  git:
    url: git@github.com:sofiakb/prayer_times.git
    ref: main
```

```shell
flutter pub get
```

<!-- USAGE EXAMPLES -->

## Usage

```dart
import 'package:prayer_times/prayer_times.dart';

void main() {
  DateTime date = DateTime.now();

  PrayerTimes test = PrayerTimes(
      params: CalculatorParams(
          coordinates: Coordinates(
            latitude: 50.3555,
            longitude: 3.11127,
          ),
          calculationMethod: CalculationMethod.mwl(),
          adjustHighLats: HigherLatitudesAdjusting.angleBased,
          asrJuristic: AsrJuristic.shafi,
          dhuhrMinutes: 0,
          numIterations: 1,
          timeFormat: TimeFormats.time24,
          date: date));

  print(test.toJson());
  print(test.nextPrayer());
  print(test.timeForPrayer(Prayer.asr));
  print(test.timeForPrayer(Prayer.fajr));
}
```

<!-- ROADMAP -->

## Roadmap

See the [open issues](https://github.com/sofiakb/prayer_times/issues) for a list of proposed
features (and known issues).

<!-- CHANGELOGS -->

## Changelogs

#### v1.0.1

- Remove parameter in nextPrayer function

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/sofiakb/prayer_times.svg?style=for-the-badge

[contributors-url]: https://github.com/sofiakb/prayer_times/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/sofiakb/prayer_times.svg?style=for-the-badge

[forks-url]: https://github.com/sofiakb/prayer_times/network/members

[stars-shield]: https://img.shields.io/github/stars/sofiakb/prayer_times.svg?style=for-the-badge

[stars-url]: https://github.com/sofiakb/prayer_times/stargazers

[issues-shield]: https://img.shields.io/github/issues/sofiakb/prayer_times.svg?style=for-the-badge

[issues-url]: https://github.com/sofiakb/prayer_times/issues

[license-shield]: https://img.shields.io/github/license/sofiakb/prayer_times.svg?style=for-the-badge

[license-url]: https://github.com/sofiakb/prayer_times/blob/main/LICENSE

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[linkedin-url]: https://www.linkedin.com/in/sofiane-akbly/