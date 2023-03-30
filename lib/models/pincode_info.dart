import 'dart:convert';

PincodeInfo pincodeInfoFromJson(String str) =>
    PincodeInfo.fromJson(json.decode(str));

String pincodeInfoToJson(PincodeInfo data) => json.encode(data.toJson());

class PincodeInfo {
  PincodeInfo({
    required this.message,
    required this.status,
    required this.postOffice,
  });

  String message;
  String status;
  List<PostOffice> postOffice;

  factory PincodeInfo.fromJson(Map<String, dynamic> json) => PincodeInfo(
        message: json["Message"],
        status: json["Status"],
        postOffice: List<PostOffice>.from(
            json["PostOffice"].map((x) => PostOffice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": List<dynamic>.from(postOffice.map((x) => x.toJson())),
      };
}

class PostOffice {
  PostOffice({
    required this.name,
    required this.description,
    required this.branchType,
    required this.deliveryStatus,
    required this.taluk,
    required this.circle,
    required this.district,
    required this.division,
    required this.region,
    required this.state,
    required this.country,
  });

  String name;
  String description;
  String branchType;
  String deliveryStatus;
  String taluk;
  String circle;
  String district;
  String division;
  String region;
  String state;
  String country;

  factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
        name: json["Name"],
        description: json["Description"],
        branchType: json["BranchType"],
        deliveryStatus: json["DeliveryStatus"],
        taluk: json["Taluk"],
        circle: json["Circle"],
        district: json["District"],
        division: json["Division"],
        region: json["Region"],
        state: json["State"],
        country: json["Country"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "BranchType": branchType,
        "DeliveryStatus": deliveryStatus,
        "Taluk": taluk,
        "Circle": circle,
        "District": district,
        "Division": division,
        "Region": region,
        "State": state,
        "Country": country,
      };
}
