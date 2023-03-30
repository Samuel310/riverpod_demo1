import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo1/providers/pincode_provider/pincode_state.dart';
import 'package:riverpod_demo1/providers/providers.dart';

class PincodeDetailScreen extends ConsumerWidget {
  const PincodeDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PincodeState pincodeState = ref.watch(Providers.pincodeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(pincodeState.pincode ?? ''),
      ),
      body: Column(
        children: [
          if (pincodeState.isLoading) const LinearProgressIndicator(),
          if (pincodeState.pincodeInfo != null)
            Expanded(
              child: ListView.builder(
                itemCount: pincodeState.pincodeInfo!.postOffice.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pincodeState.pincodeInfo!.postOffice[index].name),
                    subtitle: Text(pincodeState.pincodeInfo!.postOffice[index].toJson().toString()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
