import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo1/providers/pincode_search_history_provider/pincode_search_history_state.dart';

class PincodeSearchHistoryProvider
    extends StateNotifier<PincodeSearchHistoryState> {
  PincodeSearchHistoryProvider() : super(PincodeSearchHistoryState([]));

  void addToSearchHistory(String pincode) {
    List<String> pincodes = state.pincodes;
    int index = pincodes.indexWhere((element) => element == pincode);
    if (index == -1) {
      pincodes.add(pincode);
    } else {
      pincodes.removeAt(index);
      pincodes.insert(0, pincode);
    }
    state = PincodeSearchHistoryState(pincodes);
  }

  void deleteSearchHistory(int index) {
    List<String> pincodes = state.pincodes;
    pincodes.removeAt(index);
    state = PincodeSearchHistoryState(pincodes);
  }

  void deleteAllHistory() {
    state = PincodeSearchHistoryState([]);
  }
}
