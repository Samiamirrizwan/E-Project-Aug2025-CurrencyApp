// lib/features/history/providers/history_provider.dart

import 'package:currensee/core/providers/firebase_provider.dart';
import 'package:currensee/features/auth/providers/auth_provider.dart';
import 'package:currensee/features/converter/data/models/conversion.dart';
import 'package:currensee/features/history/data/history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository provider
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.watch(firestoreProvider));
});

// Stream provider for history
final historyStreamProvider = StreamProvider<List<Conversion>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(historyRepositoryProvider).getHistoryStream(user.uid);
  }
  return Stream.value([]);
});

// Notifier to handle history actions
final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, AsyncValue<void>>((ref) {
  return HistoryNotifier(
    ref.watch(historyRepositoryProvider),
    ref.watch(authStateChangesProvider).value?.uid,
  );
});

class HistoryNotifier extends StateNotifier<AsyncValue<void>> {
  final HistoryRepository _repository;
  final String? _userId;

  HistoryNotifier(this._repository, this._userId)
      : super(const AsyncData(null));

  // Add a conversion
  Future<void> addConversion(Conversion conversion) async {
    if (_userId == null) return;
    state = const AsyncLoading();
    try {
      await _repository.addConversion(_userId, conversion); // ✅ removed !
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Clear history
  Future<void> clearHistory() async {
    if (_userId == null) return;
    state = const AsyncLoading();
    try {
      await _repository.clearHistory(_userId); // ✅ removed !
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
