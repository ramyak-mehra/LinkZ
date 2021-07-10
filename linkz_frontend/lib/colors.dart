import 'package:flutter/material.dart';

const kGreenYellowCrayola = Color(0xFFF0F2A6);
const kRaisinBlack = Color(0xFF1A1B25);

const kRussianViolet = Color(0xFF392061);

// const Map<int, Color> primaryColorSwatch = {
//   50: Color.fromRGBO(57, 32, 97, .1),
//   100: Color.fromRGBO(57, 32, 97, .2),
//   200: Color.fromRGBO(57, 32, 97, .3),
//   300: Color.fromRGBO(57, 32, 97, .4),
//   400: Color.fromRGBO(57, 32, 97, .5),
//   500: Color.fromRGBO(57, 32, 97, .6),
//   600: Color.fromRGBO(57, 32, 97, .7),
//   700: Color.fromRGBO(57, 32, 97, .8),
//   800: Color.fromRGBO(57, 32, 97, .9),
//   900: Color.fromRGBO(57, 32, 97, 1),
// };
// const MaterialColor primaryColor = MaterialColor(392061, primaryColorSwatch);

// const Map<int, Color> scaffoldColorSwatch = {
//   50: Color.fromRGBO(240, 242, 166, .1),
//   100: Color.fromRGBO(240, 242, 166, .2),
//   200: Color.fromRGBO(240, 242, 166, .3),
//   300: Color.fromRGBO(240, 242, 166, .4),
//   400: Color.fromRGBO(240, 242, 166, .5),
//   500: Color.fromRGBO(240, 242, 166, .6),
//   600: Color.fromRGBO(240, 242, 166, .7),
//   700: Color.fromRGBO(240, 242, 166, .8),
//   800: Color.fromRGBO(240, 242, 166, .9),
//   900: Color.fromRGBO(240, 242, 166, 1),
// };
// const MaterialColor scaffoldColor =
//     MaterialColor(15790758, scaffoldColorSwatch);

// const Map<int, Color> secondaryColorSwatch = {
//   50: Color.fromRGBO(26, 27, 37, .1),
//   100: Color.fromRGBO(26, 27, 37, .2),
//   200: Color.fromRGBO(26, 27, 37, .3),
//   300: Color.fromRGBO(26, 27, 37, .4),
//   400: Color.fromRGBO(26, 27, 37, .5),
//   500: Color.fromRGBO(26, 27, 37, .6),
//   600: Color.fromRGBO(26, 27, 37, .7),
//   700: Color.fromRGBO(26, 27, 37, .8),
//   800: Color.fromRGBO(26, 27, 37, .9),
//   900: Color.fromRGBO(26, 27, 37, 1),
// };
// const MaterialColor secondaryColor =
//     MaterialColor(1710885, secondaryColorSwatch);
ThemeData customLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: kRussianViolet,
      scaffoldBackgroundColor: kGreenYellowCrayola,
      accentColor: kRaisinBlack);
}
