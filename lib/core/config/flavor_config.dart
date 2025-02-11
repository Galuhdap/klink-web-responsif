enum Flavor { DEVELOPMENT, PRODUCTION }

class ConfigApps {
  final Flavor? flavor;
  final String? baseUrl;
  static ConfigApps? _instance;

  factory ConfigApps({
    Flavor? flavor,
    String? baseUrl,
  }) {
    if (_instance == null) {
      _instance = ConfigApps._create(
        flavor,
        baseUrl
      );
    }
    return _instance!;
  }

  ConfigApps._create(this.flavor, this.baseUrl);

  static ConfigApps? get instance {
    return _instance;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;

  static bool isStaging() => _instance!.flavor == Flavor.DEVELOPMENT;
}
