import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Ads extends StatefulWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  BannerAd? banner;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerAdUnitID,
            listener: adState.bannerListener,
            request: const AdRequest())
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adaptive.h(10),
      child: banner == null ? Container() : AdWidget(ad: banner!),
    );
  }
}
