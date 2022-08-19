// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';
// // import 'anchored_adaptive_example.dart';
// // import 'inline_adaptive_example.dart';
// // import 'fluid_example.dart';
// // import 'reusable_inline_example.dart';
//
// const String testDevice = 'YOUR_DEVICE_ID';
// const int maxFailedLoadAttempts = 3;
//
// class GoogleADTest extends StatefulWidget {
//   @override
//   _GoogleADTestState createState() => _GoogleADTestState();
// }
//
// class _GoogleADTestState extends State<GoogleADTest> {
//   static final AdRequest request = AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );
//
//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;
//
//   RewardedAd? _rewardedAd;
//   int _numRewardedLoadAttempts = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//     _createRewardedAd();
//   }
//
//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: InterstitialAd.testAdUnitId,
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }
//
//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }
//
//   void _createRewardedAd() {
//     RewardedAd.load(
//         adUnitId: RewardedAd.testAdUnitId,
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('$ad loaded.');
//             _rewardedAd = ad;
//             _numRewardedLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             _numRewardedLoadAttempts += 1;
//             if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
//               _createRewardedAd();
//             }
//           },
//         ));
//   }
//
//   void _showRewardedAd() {
//     if (_rewardedAd == null) {
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) => print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedAd();
//       },
//     );
//
//     _rewardedAd!.setImmersiveMode(true);
//     _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
//     });
//     _rewardedAd = null;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('AdMob Plugin example app'),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: (String result) {
//                   switch (result) {
//                     case 'InterstitialAd':
//                       _showInterstitialAd();
//                       break;
//                     case 'RewardedAd':
//                       _showRewardedAd();
//                       break;
//                     case 'Fluid':
//                       print('Fluid');
//                       break;
//                     case 'Inline adaptive':
//                       print('Inline adaptive');
//
//                       break;
//                     case 'Anchored adaptive':
//                       print('Anchored adaptive');
//
//                       break;
//                     default:
//                       throw AssertionError('unexpected button: $result');
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   PopupMenuItem<String>(
//                     value: 'InterstitialAd',
//                     child: Text('InterstitialAd'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: 'RewardedAd',
//                     child: Text('RewardedAd'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: 'Fluid',
//                     child: Text('Fluid'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: 'Inline adaptive',
//                     child: Text('Inline adaptive'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: 'Anchored adaptive',
//                     child: Text('Anchored adaptive'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: SafeArea(
//               child: Container(
//             width: 300,
//             height: 250,
//             color: Colors.red,
//           )),
//         );
//       }),
//     );
//   }
// }
