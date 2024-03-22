import 'package:boilerplate/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';
part 'routes_store.g.dart';

class RoutesStore = _RoutesStore with _$RoutesStore;

abstract class _RoutesStore with Store {
  static final Map<String, int> routeToIndex = {Routes.dashboard: 1};

  @observable
  int currentIdx = routeToIndex[Routes.initialRoute] ?? 0;

  @action
  void changeRouteIndex(int idx) {
    currentIdx = idx;
  }
}
