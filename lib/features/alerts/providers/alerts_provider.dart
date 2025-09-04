import 'package:currensee/core/providers/firebase_provider.dart';
import 'package:currensee/features/alerts/data/alerts_repository.dart';
import 'package:currensee/features/alerts/data/models/rate_alert.dart';
import 'package:currensee/features/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  return AlertsRepository(ref.watch(firestoreProvider));
});

final alertsStreamProvider = StreamProvider<List<RateAlert>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(alertsRepositoryProvider).getAlertsStream(user.uid);
  }
  return Stream.value([]);
});

final alertsNotifierProvider =
    StateNotifierProvider<AlertsNotifier, AsyncValue<void>>((ref) {
  return AlertsNotifier(
    ref.watch(alertsRepositoryProvider),
    ref.watch(authStateChangesProvider).value?.uid,
  );
});

class AlertsNotifier extends StateNotifier<AsyncValue<void>> {
  final AlertsRepository _repository;
  final String? _userId;

  AlertsNotifier(this._repository, this._userId) : super(const AsyncData(null));

  Future<void> addAlert(RateAlert alert) async {
    if (_userId == null) return;
    state = const AsyncLoading();
    try {
      await _repository.addAlert(_userId, alert); // ✅ no need for "!"
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeAlert(String alertId) async {
    if (_userId == null) return;
    state = const AsyncLoading();
    try {
      await _repository.removeAlert(_userId, alertId); // ✅ no need for "!"
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
