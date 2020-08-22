import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.success,
    this.location,
  });

  List<Success> success;
  List<Location> location;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success:
            List<Success>.from(json["Success"].map((x) => Success.fromJson(x))),
        location: List<Location>.from(
            json["location"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": List<dynamic>.from(success.map((x) => x.toJson())),
        "location": List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    this.lat,
    this.longg,
  });

  String lat;
  String longg;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        longg: json["longg"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "longg": longg,
      };
}

class Success {
  Success({
    this.id,
    this.name,
    this.category,
    this.categoryid,
    this.address,
    this.description,
    this.contact,
    this.empcode,
    this.image,
  });

  String id;
  String name;
  Category category;
  String categoryid;
  String address;
  String description;
  String contact;
  Empcode empcode;
  String image;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        name: json["name"],
        category: categoryValues.map[json["category"]],
        categoryid: json["categoryid"],
        address: json["address"],
        description: json["description"],
        contact: json["contact"],
        empcode: empcodeValues.map[json["empcode"]],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": categoryValues.reverse[category],
        "categoryid": categoryid,
        "address": address,
        "description": description,
        "contact": contact,
        "empcode": empcodeValues.reverse[empcode],
        "image": image,
      };
}

enum Category { WEB_DEVELOPMENT, SEO, DIGITAL_MARKETING }

final categoryValues = EnumValues({
  "Digital Marketing": Category.DIGITAL_MARKETING,
  "SEO": Category.SEO,
  "Web development": Category.WEB_DEVELOPMENT
});

enum Empcode { AT0104 }

final empcodeValues = EnumValues({"AT0104": Empcode.AT0104});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
