import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_demo1/providers/pincode_provider/pincode_provider.dart';
import 'package:riverpod_demo1/providers/pincode_provider/pincode_state.dart';
import 'package:riverpod_demo1/providers/pincode_search_history_provider/pincode_search_history_provider.dart';
import 'package:riverpod_demo1/providers/pincode_search_history_provider/pincode_search_history_state.dart';
import 'package:riverpod_demo1/repositories/pincode_repo.dart';

class Providers {
  static final pincodeProvider =
      StateNotifierProvider<PincodeProvider, PincodeState>((ref) {
    return PincodeProvider(PincodeRepository(Client()),
        ref.watch(pincodeSearchHistoryProvider.notifier));
  });

  static final pincodeSearchHistoryProvider = StateNotifierProvider<
      PincodeSearchHistoryProvider, PincodeSearchHistoryState>((ref) {
    return PincodeSearchHistoryProvider();
  });
}
