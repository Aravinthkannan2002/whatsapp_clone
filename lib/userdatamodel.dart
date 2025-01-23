import 'dart:convert';

// Function to parse the JSON response and convert it to FetchUserData
FetchUserData fetchUserDataFromJson(String str) => FetchUserData.fromJson(json.decode(str));

// Function to convert FetchUserData to JSON string
String fetchUserDataToJson(FetchUserData data) => json.encode(data.toJson());

class FetchUserData {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Support support;

  FetchUserData({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  // Factory method to create FetchUserData from JSON
  factory FetchUserData.fromJson(Map<String, dynamic> json) => FetchUserData(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    support: Support.fromJson(json["support"]),
  );

  // Method to convert FetchUserData to JSON
  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "support": support.toJson(),
  };
}

class Datum {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory method to create Datum from JSON
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  // Method to convert Datum to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  // Factory method to create Support from JSON
  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  // Method to convert Support to JSON
  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
