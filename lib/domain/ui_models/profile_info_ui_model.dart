import '../../data/response/api_profile_info_response.dart';

class ProfileInfoUiModel {
  final int id;
  final String imageUrl;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String licenceNumber;
  final String licenceDate;
  final String bankNumber;
  final String salary;

  final String balancePound;
  final String balanceDollar;
  final String balanceLira;
  final String balanceEuro;

  final int collectionCount;
  final int takenCount;
  final int reviewCount;
  final List<String> plates;

  ProfileInfoUiModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.licenceNumber,
    required this.licenceDate,
    required this.bankNumber,
    required this.salary,
    required this.balancePound,
    required this.balanceDollar,
    required this.balanceLira,
    required this.balanceEuro,
    required this.collectionCount,
    required this.takenCount,
    required this.reviewCount,
    required this.plates,
  });

  factory ProfileInfoUiModel.fromApi(ApiProfileInfoResponse response) {
    final profile = response.data;

    return ProfileInfoUiModel(
      id: profile?.id ?? 0,
      imageUrl: profile?.img ?? '',
      name: profile?.name ?? '',
      phone: profile?.phone ?? '',
      email: profile?.email ?? '',
      address: profile?.adres ?? '',
      licenceNumber: profile?.licenceNumber ?? '',
      licenceDate: profile?.licenceDate ?? '',
      bankNumber: profile?.bankNumber ?? '',
      salary: profile?.salary ?? '0',
      balancePound: profile?.balancePound ?? '0',
      balanceDollar: profile?.balanceDollar ?? '0',
      balanceLira: profile?.balanceLira ?? '0',
      balanceEuro: profile?.balanceEuro ?? '0',
      collectionCount: profile?.collectionCount ?? 0,
      takenCount: profile?.takenCount ?? 0,
      reviewCount: profile?.reviewCount ?? 0,
      plates: profile?.plate ?? [],
    );
  }
}
