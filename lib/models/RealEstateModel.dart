class RealEstate {
  final int idRealEstate;
  final String realEstateName;
  final String realEstateDescription;
  final String realEstateAddress;
  final String realEstateLogo;

  RealEstate({
    required this.idRealEstate,
    required this.realEstateName,
    required this.realEstateDescription,
    required this.realEstateAddress,
    required this.realEstateLogo,
  });

  factory RealEstate.fromJson(Map<String, dynamic> json) {
    return RealEstate(
      idRealEstate: json['idRealEstate'],
      realEstateName: json['realEstateName'],
      realEstateDescription: json['realEstateDescription'],
      realEstateAddress: json['realEstateAddress'],
      realEstateLogo: json['realEstateLogo'],
    );
  }
}
