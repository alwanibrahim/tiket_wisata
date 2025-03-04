/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/home-icon.png
  AssetGenImage get homeIcon =>
      const AssetGenImage('assets/icons/home-icon.png');

  /// File path: assets/icons/icons.png
  AssetGenImage get icons => const AssetGenImage('assets/icons/icons.png');

  /// List of all assets
  List<AssetGenImage> get values => [homeIcon, icons];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alex-varela-pkmEdKpFM4k-unsplash.jpg
  AssetGenImage get alexVarelaPkmEdKpFM4kUnsplash =>
      const AssetGenImage('assets/images/alex-varela-pkmEdKpFM4k-unsplash.jpg');

  /// File path: assets/images/gambar01.png
  AssetGenImage get gambar01 =>
      const AssetGenImage('assets/images/gambar01.png');

  /// File path: assets/images/gambar02.png
  AssetGenImage get gambar02 =>
      const AssetGenImage('assets/images/gambar02.png');

  /// File path: assets/images/signUp01.png
  AssetGenImage get signUp01 =>
      const AssetGenImage('assets/images/signUp01.png');

  /// File path: assets/images/signUp02.png
  AssetGenImage get signUp02 =>
      const AssetGenImage('assets/images/signUp02.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    alexVarelaPkmEdKpFM4kUnsplash,
    gambar01,
    gambar02,
    signUp01,
    signUp02,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
