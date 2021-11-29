import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());


@HiveType(typeId: 1)
class UserModel {
    UserModel({
        this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company,
    });

    @HiveField(0)
    int? id;
    @HiveField(1)
    String? name;
    @HiveField(2)
    String? username;
    @HiveField(3)
    String? email;
    @HiveField(4)
    Address? address;
    @HiveField(5)
    String? phone;
    @HiveField(6)
    String? website;
    @HiveField(7)
    Company? company;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        phone: json["phone"] == null ? null : json["phone"],
        website: json["website"] == null ? null : json["website"],
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "address": address == null ? null : address!.toJson(),
        "phone": phone == null ? null : phone,
        "website": website == null ? null : website,
        "company": company == null ? null : company!.toJson(),
    };
}

@HiveType(typeId: 2)
class Address {
    Address({
        this.street,
        this.suite,
        this.city,
        this.zipcode,
        this.geo,
    });

    @HiveField(0)
    String? street;
    @HiveField(1)
    String? suite;
    @HiveField(2)
    String? city;
    @HiveField(3)
    String? zipcode;
    @HiveField(4)
    Geo? geo;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"] == null ? null : json["street"],
        suite: json["suite"] == null ? null : json["suite"],
        city: json["city"] == null ? null : json["city"],
        zipcode: json["zipcode"] == null ? null : json["zipcode"],
        geo: json["geo"] == null ? null : Geo.fromJson(json["geo"]),
    );

    Map<String, dynamic> toJson() => {
        "street": street == null ? null : street,
        "suite": suite == null ? null : suite,
        "city": city == null ? null : city,
        "zipcode": zipcode == null ? null : zipcode,
        "geo": geo == null ? null : geo!.toJson(),
    };
}

@HiveType(typeId: 3)
class Geo {
    Geo({
        this.lat,
        this.lng,
    });

    @HiveField(0)
    String? lat;
    @HiveField(1)
    String? lng;

    factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
    };
}

@HiveType(typeId: 4)
class Company {
    Company({
        this.name,
        this.catchPhrase,
        this.bs,
    });

    @HiveField(0)
    String? name;
    @HiveField(1)
    String? catchPhrase;
    @HiveField(2)
    String? bs;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"] == null ? null : json["name"],
        catchPhrase: json["catchPhrase"] == null ? null : json["catchPhrase"],
        bs: json["bs"] == null ? null : json["bs"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "catchPhrase": catchPhrase == null ? null : catchPhrase,
        "bs": bs == null ? null : bs,
    };
}