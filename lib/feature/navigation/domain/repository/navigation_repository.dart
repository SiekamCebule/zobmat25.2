import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';

abstract interface class NavigationRepository {
  Future<NavigationEntry> getCurrentEntry();
  Future<void> goTo(NavigationEntry entry);
}
