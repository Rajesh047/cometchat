class AppSettings{

  final String? subscriptionType;
  final List<String>? roles;
  final String? region;
  final bool? autoEstablishSocketConnection;

  AppSettings._builder(AppSettingsBuilder builder)
      : subscriptionType = builder.subscriptionType,
        roles = builder.roles,
        region = builder.region,
        autoEstablishSocketConnection = builder.autoEstablishSocketConnection??true;


}

class AppSettingsBuilder {
  String? subscriptionType ;
  List<String>? roles  ;
  String? region  ;
  bool? autoEstablishSocketConnection;

  AppSettingsBuilder();

  AppSettings build() {
    return AppSettings._builder(this);
  }
}
