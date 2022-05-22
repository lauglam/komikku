import 'package:komikku/views/latest_update.dart';
import 'package:komikku/views/login.dart';
import 'package:komikku/views/me.dart';
import 'package:komikku/views/subscribes.dart';

var staticRoutes = {
  '/latest-update': (context) => const LatestUpdate(),
  '/subscribes': (context) => const Subscribes(),
  '/me': (context) => const Me(),
  '/login': (context) => const Login(),
};
