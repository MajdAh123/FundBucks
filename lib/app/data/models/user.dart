import 'package:app/app/data/models/country.dart';
import 'package:app/app/data/models/models.dart';
import 'package:collection/collection.dart';

class User {
  int? id;
  String? username;
  String? email;
  String? avatar;
  String? firstname;
  String? lastname;
  dynamic gender;
  dynamic address;
  dynamic city;
  dynamic bankUsername;
  dynamic bankName;
  dynamic bankUserId;
  dynamic iban;
  DateTime? emailVerifiedAt;
  String? balance;
  String? differencePercent;
  String? returnPercent;
  String? returnValue;
  String? currentValue;
  dynamic mobile;
  int? isBanned;
  dynamic verCod;
  dynamic verCodeSendAt;
  int? isBankVer;
  int? pauseCalc;
  int? isAdmin;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic planId;
  dynamic countryId;
  Plan? plan;
  Country? country;
  Currency? currency;
  String? type;
  String? nationality;
  String? passport;
  String? nationality_code;
  String? passport_image;
  int? passport_status;
  int? passport_required;
  int? account_number;
  String? fcm_token;

  User({
    this.id,
    this.username,
    this.email,
    this.avatar,
    this.firstname,
    this.lastname,
    this.gender,
    this.address,
    this.city,
    this.bankUsername,
    this.bankName,
    this.bankUserId,
    this.iban,
    this.emailVerifiedAt,
    this.balance,
    this.differencePercent,
    this.returnPercent,
    this.returnValue,
    this.currentValue,
    this.mobile,
    this.isBanned,
    this.verCod,
    this.verCodeSendAt,
    this.isBankVer,
    this.pauseCalc,
    this.isAdmin,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.planId,
    this.countryId,
    this.plan,
    this.country,
    this.currency,
    this.type,
    this.nationality,
    this.passport,
    this.nationality_code,
    this.passport_image,
    this.passport_status,
    this.passport_required,
    this.account_number,
    this.fcm_token,
  });

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, avatar: $avatar, type: $type, firstname: $firstname, lastname: $lastname, gender: $gender, address: $address, city: $city, bankUsername: $bankUsername, bankName: $bankName, bankUserId: $bankUserId, iban: $iban, emailVerifiedAt: $emailVerifiedAt, balance: $balance, differencePercent: $differencePercent, returnPercent: $returnPercent, returnValue: $returnValue, currentValue: $currentValue, mobile: $mobile, isBanned: $isBanned, verCod: $verCod, verCodeSendAt: $verCodeSendAt, isBankVer: $isBankVer, pauseCalc: $pauseCalc, isAdmin: $isAdmin, fcmToken: $fcmToken, createdAt: $createdAt, updatedAt: $updatedAt, planId: $planId, countryId: $countryId, plan: $plan, country: $country, currency: $currency, nationality: $nationality, passport: $passport, nationality_code: $nationality_code, passport_image: $passport_image, passport_status: $passport_status, passport_required: $passport_required, account_number: $account_number, fcm_token: $fcm_token)';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      gender: json['gender'] as dynamic,
      address: json['address'] as dynamic,
      city: json['city'] as dynamic,
      bankUsername: json['bank_username'] as dynamic,
      bankName: json['bank_name'] as dynamic,
      type: json['type'] as dynamic,
      bankUserId: json['bank_user_id'] as dynamic,
      iban: json['iban'] as dynamic,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
      balance: json['balance'] as String?,
      differencePercent: json['difference_percent'] as String?,
      returnPercent: json['return_percent'] as String?,
      returnValue: json['return_value'] as String?,
      currentValue: json['current_value'] as String?,
      mobile: json['mobile'] as dynamic,
      isBanned: json['is_banned'] as int?,
      verCod: json['ver_cod'] as dynamic,
      verCodeSendAt: json['ver_code_send_at'] as dynamic,
      isBankVer: json['is_bank_ver'] as int?,
      pauseCalc: json['pause_calc'] as int?,
      isAdmin: json['is_admin'] as int?,
      fcmToken: json['fcm_token'] as String?,
      nationality: json['nationality'] as String?,
      passport: json['passport'] as String?,
      nationality_code: json['nationality_code'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      planId: json['plan_id'] as dynamic,
      countryId: json['country_id'] as dynamic,
      plan: json['plan'] == null ? null : Plan.fromJson(json['plan']),
      country:
          json['country'] == null ? null : Country.fromJson(json['country']),
      currency:
          json['currency'] == null ? null : Currency.fromJson(json['currency']),
      passport_image: json['passport_image'] as String?,
      passport_status: json['passport_status'] as int?,
      passport_required: json['passport_required'] as int?,
      account_number: json['account_number'] as int?,
      fcm_token: json['fcm_token'] as String?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'avatar': avatar,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'address': address,
        'city': city,
        'bank_username': bankUsername,
        'bank_name': bankName,
        'bank_user_id': bankUserId,
        'iban': iban,
        'type': type,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'balance': balance,
        'difference_percent': differencePercent,
        'return_percent': returnPercent,
        'return_value': returnValue,
        'current_value': currentValue,
        'mobile': mobile,
        'is_banned': isBanned,
        'ver_cod': verCod,
        'ver_code_send_at': verCodeSendAt,
        'is_bank_ver': isBankVer,
        'pause_calc': pauseCalc,
        'is_admin': isAdmin,
        'fcm_token': fcmToken,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'plan_id': planId,
        'country_id': countryId,
        'nationality': nationality,
        'passport': passport,
        'nationality_code': nationality_code,
        'passport_image': passport_image,
        'passport_status': passport_status,
        'passport_required': passport_required,
        'account_number': account_number,
        'fcm_token': fcm_token
        // 'plan': plan?.toJson(),
      };

  User copyWith(
      {int? id,
      String? username,
      String? email,
      String? avatar,
      String? firstname,
      String? lastname,
      String? passport,
      String? nationality,
      String? nationality_code,
      dynamic gender,
      dynamic address,
      dynamic city,
      dynamic bankUsername,
      dynamic bankName,
      dynamic bankUserId,
      dynamic iban,
      DateTime? emailVerifiedAt,
      String? balance,
      String? differencePercent,
      String? returnPercent,
      String? returnValue,
      String? currentValue,
      dynamic mobile,
      int? isBanned,
      dynamic verCod,
      dynamic verCodeSendAt,
      int? isBankVer,
      int? pauseCalc,
      int? isAdmin,
      String? fcmToken,
      DateTime? createdAt,
      DateTime? updatedAt,
      dynamic planId,
      dynamic countryId,
      Plan? plan,
      String? passport_image,
      int? passport_status,
      int? passport_required,
      int? account_number,
      String? fcm_token}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      nationality: nationality ?? this.nationality,
      passport: passport ?? this.passport,
      nationality_code: nationality_code ?? this.nationality_code,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      city: city ?? this.city,
      bankUsername: bankUsername ?? this.bankUsername,
      bankName: bankName ?? this.bankName,
      bankUserId: bankUserId ?? this.bankUserId,
      iban: iban ?? this.iban,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      balance: balance ?? this.balance,
      differencePercent: differencePercent ?? this.differencePercent,
      returnPercent: returnPercent ?? this.returnPercent,
      returnValue: returnValue ?? this.returnValue,
      currentValue: currentValue ?? this.currentValue,
      mobile: mobile ?? this.mobile,
      isBanned: isBanned ?? this.isBanned,
      verCod: verCod ?? this.verCod,
      verCodeSendAt: verCodeSendAt ?? this.verCodeSendAt,
      isBankVer: isBankVer ?? this.isBankVer,
      pauseCalc: pauseCalc ?? this.pauseCalc,
      isAdmin: isAdmin ?? this.isAdmin,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      planId: planId ?? this.planId,
      countryId: countryId ?? this.countryId,
      plan: plan ?? this.plan,
      passport_image: passport_image ?? this.passport_image,
      passport_status: passport_status ?? this.passport_status,
      passport_required: passport_required ?? this.passport_required,
      account_number: account_number ?? this.account_number,
      fcm_token: fcm_token ?? this.fcm_token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      nationality.hashCode ^
      nationality_code.hashCode ^
      passport.hashCode ^
      email.hashCode ^
      avatar.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      gender.hashCode ^
      address.hashCode ^
      city.hashCode ^
      bankUsername.hashCode ^
      bankName.hashCode ^
      bankUserId.hashCode ^
      iban.hashCode ^
      emailVerifiedAt.hashCode ^
      balance.hashCode ^
      differencePercent.hashCode ^
      returnPercent.hashCode ^
      returnValue.hashCode ^
      currentValue.hashCode ^
      mobile.hashCode ^
      isBanned.hashCode ^
      verCod.hashCode ^
      verCodeSendAt.hashCode ^
      isBankVer.hashCode ^
      pauseCalc.hashCode ^
      isAdmin.hashCode ^
      fcmToken.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      planId.hashCode ^
      countryId.hashCode ^
      plan.hashCode ^
      passport_image.hashCode ^
      passport_status.hashCode ^
      passport_required.hashCode ^
      account_number.hashCode ^
      fcm_token.hashCode;
}
