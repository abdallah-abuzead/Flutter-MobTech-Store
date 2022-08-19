import 'dart:io';

class AdHelper {
  static String get bannerAdUnitID {
    if (Platform.isAndroid)
      return 'ca-app-pub-6541318803364522/2520669281';
    else
      throw UnsupportedError('Unsupported platform');
  }
}
