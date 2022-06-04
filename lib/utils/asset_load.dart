abstract class AssetLoad {
  static const assetsPath = 'assets/';
}

abstract class AnimationAsset {
  static const animatonAssetPath = 'animations/';

  static String named(String animatioName) {
    return "${AssetLoad.assetsPath}$animatonAssetPath$animatioName.json";
  }
}

abstract class IconsAsset extends AssetLoad {
  static const iconsAssetPath = 'icons/';

  static String named(String iconName) {
    return "${AssetLoad.assetsPath}$iconsAssetPath$iconName.svg";
  }
}

abstract class ImagesAsset extends AssetLoad {
  static const imagesAssetPath = 'images/';

  static String named(String imageName) {
    return "${AssetLoad.assetsPath}$imagesAssetPath$imageName.svg";
  }
}
