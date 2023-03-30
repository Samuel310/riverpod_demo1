import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_demo1/providers/pincode_provider/pincode_state.dart';
import 'package:riverpod_demo1/providers/pincode_search_history_provider/pincode_search_history_state.dart';
import 'package:riverpod_demo1/providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PincodeState>(Providers.pincodeProvider, (previous, next) {
      if (next.pincodeInfo != null && next.pincode != null) {
        _textEditingController.text = '';
        GoRouter.of(context).go('/pincode/${next.pincode}', extra: next.pincodeInfo);
      }
      if (next.errorMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.errorMsg!)));
      }
    });

    PincodeState pincodeState = ref.watch(Providers.pincodeProvider);
    PincodeSearchHistoryState pincodeSearchHistoryState = ref.watch(Providers.pincodeSearchHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pincode "),
      ),
      body: Column(
        children: [
          if (pincodeState.isLoading) const LinearProgressIndicator(),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textEditingController,
                  onFieldSubmitted: (value) {
                    ref.read(Providers.pincodeProvider.notifier).loadPincodeInfo(pincode: value);
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(Providers.pincodeProvider.notifier).loadPincodeInfo(pincode: _textEditingController.text);
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pincodeSearchHistoryState.pincodes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    GoRouter.of(context).go('/pincode/${pincodeSearchHistoryState.pincodes[index]}');
                  },
                  title: Text(pincodeSearchHistoryState.pincodes[index]),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(Providers.pincodeSearchHistoryProvider.notifier).deleteSearchHistory(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: pincodeSearchHistoryState.pincodes.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                ref.read(Providers.pincodeSearchHistoryProvider.notifier).deleteAllHistory();
              },
              child: const Icon(
                Icons.delete_forever,
              ),
            )
          : null,
    );
  }
}
