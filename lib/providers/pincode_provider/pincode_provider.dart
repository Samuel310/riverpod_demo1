import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo1/models/pincode_info.dart';
import 'package:riverpod_demo1/providers/pincode_provider/pincode_state.dart';
import 'package:riverpod_demo1/providers/pincode_search_history_provider/pincode_search_history_provider.dart';
import 'package:riverpod_demo1/repositories/pincode_repo.dart';

class PincodeProvider extends StateNotifier<PincodeState> {
  final PincodeRepository _pincodeRepository;
  final PincodeSearchHistoryProvider _pincodeSearchHistoryProvider;

  PincodeProvider(this._pincodeRepository, this._pincodeSearchHistoryProvider)
      : super(
          PincodeState(
            isLoading: false,
            pincodeInfo: null,
            errorMsg: null,
            pincode: null,
          ),
        );

  void loadPincodeInfo({required String pincode}) async {
    try {
      if (state.isLoading) return;
      state = PincodeState(
        isLoading: true,
        pincodeInfo: null,
        errorMsg: null,
        pincode: null,
      );
      PincodeInfo pincodeInfo = await _pincodeRepository.getPincodeDetails(
        pincode: pincode,
      );
      _pincodeSearchHistoryProvider.addToSearchHistory(pincode);
      state = PincodeState(
        isLoading: false,
        pincodeInfo: pincodeInfo,
        errorMsg: null,
        pincode: pincode,
      );
    } catch (e) {
      state = PincodeState(
        isLoading: false,
        pincodeInfo: null,
        pincode: null,
        errorMsg: e.toString(),
      );
    }
  }

  void getPincodeInfoFromObject({
    required String pincode,
    required Object? pincodeInfo,
  }) async {
    try {
      if (pincodeInfo != null) {
        _pincodeSearchHistoryProvider.addToSearchHistory(pincode);
        state = PincodeState(
          isLoading: false,
          pincodeInfo: pincodeInfo as PincodeInfo,
          errorMsg: null,
          pincode: pincode,
        );
      } else {
        loadPincodeInfo(pincode: pincode);
      }
    } catch (e) {
      loadPincodeInfo(pincode: pincode);
    }
  }
}
