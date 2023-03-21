import 'package:app/app/data/models/models.dart';
import 'package:collection/collection.dart';

class User {
  int? id;
  String? username;
  String? email;
  String? avatar;
  String? firstname;
  String? lastname;
  String? gender;
  String? address;
  String? city;
  String? bankUsername;
  String? bankName;
  String? bankUserId;
  String? iban;
  DateTime? emailVerifiedAt;
  String? balance;
  String? differencePercent;
  String? returnPercent;
  String? returnValue;
  String? currentValue;
  String? mobile;
  int? isBanned;
  dynamic verCod;
  dynamic verCodeSendAt;
  int? isBankVer;
  int? pauseCalc;
  int? isAdmin;
  dynamic fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? planId;
  int? countryId;
  Plan? plan;

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
  });

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, avatar: $avatar, firstname: $firstname, lastname: $lastname, gender: $gender, address: $address, city: $city, bankUsername: $bankUsername, bankName: $bankName, bankUserId: $bankUserId, iban: $iban, emailVerifiedAt: $emailVerifiedAt, balance: $balance, differencePercent: $differencePercent, returnPercent: $returnPercent, returnValue: $returnValue, currentValue: $currentValue, mobile: $mobile, isBanned: $isBanned, verCod: $verCod, verCodeSendAt: $verCodeSendAt, isBankVer: $isBankVer, pauseCalc: $pauseCalc, isAdmin: $isAdmin, fcmToken: $fcmToken, createdAt: $createdAt, updatedAt: $updatedAt, planId: $planId, countryId: $countryId, plan: $plan)';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        avatar: json['avatar'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        gender: json['gender'] as String?,
        address: json['address'] as String?,
        city: json['city'] as String?,
        bankUsername: json['bank_username'] as String?,
        bankName: json['bank_name'] as String?,
        bankUserId: json['bank_user_id'] as String?,
        iban: json['iban'] as String?,
        emailVerifiedAt: json['email_verified_at'] == null
            ? null
            : DateTime.parse(json['email_verified_at'] as String),
        balance: json['balance'] as String?,
        differencePercent: json['difference_percent'] as String?,
        returnPercent: json['return_percent'] as String?,
        returnValue: json['return_value'] as String?,
        currentValue: json['current_value'] as String?,
        mobile: json['mobile'] as String?,
        isBanned: json['is_banned'] as int?,
        verCod: json['ver_cod'] as dynamic,
        verCodeSendAt: json['ver_code_send_at'] as dynamic,
        isBankVer: json['is_bank_ver'] as int?,
        pauseCalc: json['pause_calc'] as int?,
        isAdmin: json['is_admin'] as int?,
        fcmToken: json['fcm_token'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        planId: json['plan_id'] as dynamic,
        countryId: json['country_id'] as int?,
        plan: json['plan'] == null
            ? null
            : Plan.fromJson(json['plan'] as Map<String, dynamic>),
      );

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
        // 'plan': plan?.toJson(),
      };

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
      plan.hashCode;
}
