import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';
import 'package:cinema_hub/constants/misc.dart';
import 'package:cinema_hub/enums/route_type.dart';
import 'package:cinema_hub/extensions/string_extension.dart';
import 'package:cinema_hub/models/snackbar_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../enums/snackbar_type.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

/// returns a value inside range [min,max] based on [interpolant]
double lerp({
  required double min,
  required double max,
  required double interpolant,
}) {
  final val = (min + ((max - min) * interpolant));
  final valClamped = clampDouble(val, min, max);

  // print(
  //     '[lerp]: range = [$min, $max], interpolant = $interpolant, valClamped = $valClamped');
  return valClamped;
}

String generateRandomString({required int strLength}) {
  var r = math.Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(strLength, (index) => chars[r.nextInt(chars.length)])
      .join();
}

Future<Object?> navigateToRoute({
  required BuildContext context,
  required RouteType routeName,
  bool removePrevious = false,
  bool bottomMenuNavigation = false,
  Object? arguments,
}) async {
  String route = routeName.toRoute();

  if (removePrevious) {
    return Navigator.of(context).popAndPushNamed(
      route,
      // (route) => false,
      arguments: arguments,
    );
  } else {
    // * navigate in the same way as bottom menu buttons
    if (/*routeName.isBottomMenuRoute() && */ bottomMenuNavigation) {
      // keyApp.currentState!.onScreenChanged(routeName: routeName);
      return true;
    } else {
      return await Navigator.of(context).pushNamed(
        route,
        arguments: arguments,
      );
    }
  }
}

Color getRandomColor() {
  Color color =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(255);
  return color;
}

/// Determines if a string formatted json contains all of the specified fields
bool isTypeOfJson(
    {required String? jsonString, required List<String> targetObjFields}) {
  jsonString ??= '';

  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
  bool result = listEquals(jsonMap.keys.toList(), targetObjFields);

  // print('jsonMap = $jsonMap');
  // print('targetObjFields = $targetObjFields => result = $result');

  return result;
}

/// Returns the image? the user uploaded
// Future<File?> uploadImage({
//   CropStyle? cropStyle,
//   int? imageQuality = 100,
// }) async {
//   // waiting for user to pick image(s)
//   final files = await imageHelper.pickImage(imageQuality: imageQuality);

//   File? image;

//   if (files.isNotEmpty) {
//     final result = files.first;
//     image = File(result.path);

//     // crop the image
//     final croppedFile = await imageHelper.crop(file: result);

//     if (croppedFile != null) {
//       image = File(croppedFile.path);
//     }
//   }

//   return image;
// }

/// returns black/white based on the background (bright bg = white color and vice versa
Color getColorAdaptiveBg({
  required Color bgColor,
  double luminacityThreshold = 0.5,
}) {
  int d = 0;

  // Counting the perceptive luminance - human eye favors green color...
  double luminance =
      (0.299 * bgColor.red + 0.587 * bgColor.green + 0.114 * bgColor.blue) /
          255;

  // bright colors - black font
  // dark colors - white font
  d = luminance > luminacityThreshold ? 0 : 255;

  return Color.fromARGB(bgColor.alpha, d, d, d);
}

void showSnackBar({
  required BuildContext context,
  required SnackBarData snackBarData,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: snackBarData.snackbarType.toColor(),
      duration: Duration(
          milliseconds:
              (Misc.snackbarDuration * snackBarData.scalerDuration).round()),
      content: Center(
        child: Text(
          snackBarData.capitalizeFirstWord
              ? snackBarData.text.capitalizeFirstLetterEachWord()
              : snackBarData.text,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

// Future<String> getAppVersion() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   return packageInfo.version;
// }

Future<bool> isNewVersion({
  required String versionSystem,
  required String versionUser,
}) async {
  final versionSystem_ = _versionToVal(versionSystem);
  final versionUser_ = _versionToVal(versionUser);

  // old = [1.0.0], new = [1.0.1]:
  // old = [1.0.0], new = [1.1.0] =>
  final indexes = List.generate(versionSystem_.length, (index) => index);

  final result = indexes.any(
    (index) => versionSystem_[index] > versionUser_[index],
  );

  // print(
  //     'versionUser = $versionUser_, valueCached = $versionSystem_ => $result');

  return result;
}

List<int> _versionToVal(String version) =>
    version.split('.').map((s) => int.tryParse(s) ?? 0).toList();

String getUUID() => uuid.v4();

int getRandomNumber(int a, int b) {
  Random random = Random();
  // Generate a random number within the range [a, b]
  int randomNumber = a + random.nextInt(b - a + 1);

  // debugPrint("Random number within the range [$a, $b]: $randomNumber");

  return randomNumber;
}

/// returns the duration within [durationRange] that is calculated using  [interpolant]
/// For example: d1 = Duration(minutes: 5), d2 = Duration(minutes: 10), interpolant = 0.5 => Duration(minutes: 7.5)
Duration toInterpolantDuration({
  required List<Duration> durationRange,
  required double interpolant,
}) {
  final millisRange =
      durationRange.map((duration) => duration.inMilliseconds).toList();

  millisRange.sort();

  // the amount of millis between [min,max] based on interpolant
  final millisInterpolant = lerp(
    min: millisRange[0].toDouble(),
    max: millisRange[1].toDouble(),
    interpolant: interpolant,
  ).round();

  // converting millis back to duration
  final result = Duration(milliseconds: millisInterpolant);

  // print(
  //     '[toInterpolantDuration]: durationRange = $durationRange, interpolant = $interpolant, result = $result');
  return result;
}

Duration findClosestDuration({
  required Duration target,
  required List<Duration> durations,
}) {
  Duration closestDuration = durations.first;
  Duration difference = (durations.first - target).abs();

  for (var duration in durations) {
    Duration currentDifference = (duration - target).abs();

    if (currentDifference < difference) {
      closestDuration = duration;
      difference = currentDifference;
    }
  }

  // print(
  //     'durations = $durations, target = $target, closestDuration = $closestDuration');
  return closestDuration;
}

scrollToTop(ScrollController scrollController) {
  if (scrollController.positions.isEmpty) {
    print(
        '[bruh]: Probably forgot to attach the controller to a scrollable widget');
    return;
  }

  scrollController.animateTo(
    0,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeIn,
  );
}

bool toRandom5050() => getRandomNumber(0, 1000) % 2 == 0;

/// gets the <id> or <val> portion of the pair
String getIdComponent({
  required String str,
  bool getId = false,
  bool getVal = false,
}) {
  final components = str.split('/');
  if (components.length != 2) return components[0];

  return getId
      ? components[0]
      : getVal
          ? components[1]
          : '';
}

/// verifies if [str] is a valid pair and returns it; Otherwise [str] is considered as the <val> portion of the pair, and a newly generated id is generated and appended to it
String getIdPair({
  String? str,
}) {
  str ??= '';
  final isValidPair = str.split('/').length == 2;

  // valid <id>/<val> components -> exit
  if (isValidPair) return str;

  // generate an id
  final id = getUUID().substring(0, Config.lengthId);

  // [str] is assumed to be the value of the pair, append it to id
  final pair = '$id/$str';

  return pair;
}

/// sets the <id> or <val> portion of the pair
String setIdComponent({
  required String str,
  String? setId,
  String? setVal,
}) {
  var components = str.split('/');

  if (setId != null) {
    components[0] = setId;
  }
  if (setVal != null) {
    components[1] = setVal;
  }

  final pair = components.join();

  return pair;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

Future simulateScrollDown(ScrollController scrollController) async {
  await Future.delayed(const Duration(milliseconds: 1500));

  if (scrollController.positions.isEmpty) {
    print(
        '[bruh]: Probably forgot to attach the controller to a scrollable widget');
    return;
  }

  scrollController.animateTo(
    scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 10000),
    curve: Curves.linear,
  );
}
