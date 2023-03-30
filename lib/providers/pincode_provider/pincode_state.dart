import 'package:riverpod_demo1/models/pincode_info.dart';

class PincodeState {
  final bool isLoading;
  final PincodeInfo? pincodeInfo;
  final String? errorMsg;
  final String? pincode;

  PincodeState({
    required this.isLoading,
    required this.pincodeInfo,
    required this.errorMsg,
    required this.pincode,
  });
}
