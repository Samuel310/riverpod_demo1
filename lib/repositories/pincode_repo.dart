import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:riverpod_demo1/models/pincode_info.dart';

class PincodeRepository {
  final Client _httpClient;
  PincodeRepository(this._httpClient);

  Future<PincodeInfo> getPincodeDetails({
    required String pincode,
  }) async {
    try {
      log("searching.. $pincode");
      if (pincode.isEmpty) throw "Pincode cannot be empty";
      Response response = await _httpClient.get(
        Uri.parse("http://www.postalpincode.in/api/pincode/$pincode"),
      );
      log(response.body);
      if (response.statusCode != 200) {
        throw response.body;
      }
      if (json.decode(response.body)["Status"] == "Error") {
        throw json.decode(response.body)["Message"];
      }
      return pincodeInfoFromJson(response.body);
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
