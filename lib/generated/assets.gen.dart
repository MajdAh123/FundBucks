/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/message-pop.mp3
  String get messagePop => 'assets/sounds/message-pop.mp3';

  /// File path: assets/sounds/send-click.wav
  String get sendClick => 'assets/sounds/send-click.wav';

  /// List of all assets
  List<String> get values => [messagePop, sendClick];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/alert.png
  AssetGenImage get alert => const AssetGenImage('assets/images/png/alert.png');

  /// File path: assets/images/png/logo-app-2.png
  AssetGenImage get logoApp2 =>
      const AssetGenImage('assets/images/png/logo-app-2.png');

  /// File path: assets/images/png/logo-app.png
  AssetGenImage get logoApp =>
      const AssetGenImage('assets/images/png/logo-app.png');

  /// File path: assets/images/png/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/png/logo.png');

  /// File path: assets/images/png/profile.png
  AssetGenImage get profile =>
      const AssetGenImage('assets/images/png/profile.png');

  /// File path: assets/images/png/splash.jpeg
  AssetGenImage get splash =>
      const AssetGenImage('assets/images/png/splash.jpeg');

  /// File path: assets/images/png/splashUpdated.png
  AssetGenImage get splashUpdated =>
      const AssetGenImage('assets/images/png/splashUpdated.png');

  /// File path: assets/images/png/wire-transfer.png
  AssetGenImage get wireTransfer =>
      const AssetGenImage('assets/images/png/wire-transfer.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        alert,
        logoApp2,
        logoApp,
        logo,
        profile,
        splash,
        splashUpdated,
        wireTransfer
      ];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/arcticonsCalculator.svg
  SvgGenImage get arcticonsCalculator =>
      const SvgGenImage('assets/images/svg/arcticonsCalculator.svg');

  /// File path: assets/images/svg/bell.svg
  SvgGenImage get bell => const SvgGenImage('assets/images/svg/bell.svg');

  /// File path: assets/images/svg/dow-jones-icon.svg
  SvgGenImage get dowJonesIcon =>
      const SvgGenImage('assets/images/svg/dow-jones-icon.svg');

  /// File path: assets/images/svg/h-logo.svg
  SvgGenImage get hLogo => const SvgGenImage('assets/images/svg/h-logo.svg');

  /// File path: assets/images/svg/heroiconsUser.svg
  SvgGenImage get heroiconsUser =>
      const SvgGenImage('assets/images/svg/heroiconsUser.svg');

  /// File path: assets/images/svg/home.svg
  SvgGenImage get home => const SvgGenImage('assets/images/svg/home.svg');

  /// File path: assets/images/svg/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/images/svg/logo.svg');

  /// File path: assets/images/svg/logoDark.svg
  SvgGenImage get logoDark =>
      const SvgGenImage('assets/images/svg/logoDark.svg');

  /// File path: assets/images/svg/splashLogo.svg
  SvgGenImage get splashLogo =>
      const SvgGenImage('assets/images/svg/splashLogo.svg');

  /// File path: assets/images/svg/upload-icon.svg
  SvgGenImage get uploadIcon =>
      const SvgGenImage('assets/images/svg/upload-icon.svg');

  /// File path: assets/images/svg/user.svg
  SvgGenImage get user => const SvgGenImage('assets/images/svg/user.svg');

  /// File path: assets/images/svg/userDark.svg
  SvgGenImage get userDark =>
      const SvgGenImage('assets/images/svg/userDark.svg');

  /// File path: assets/images/svg/wire-transfer.svg
  SvgGenImage get wireTransfer =>
      const SvgGenImage('assets/images/svg/wire-transfer.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        arcticonsCalculator,
        bell,
        dowJonesIcon,
        hLogo,
        heroiconsUser,
        home,
        logo,
        logoDark,
        splashLogo,
        uploadIcon,
        user,
        userDark,
        wireTransfer
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
