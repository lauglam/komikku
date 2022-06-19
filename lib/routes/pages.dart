import 'package:get/get.dart';

import '../modules/details/binding.dart';
import '../modules/home/binding.dart';
import '../modules/login/binding.dart';
import '../modules/reading/binding.dart';
import '../modules/search/binding.dart';
import '../modules/shell/binding.dart';
import '../modules/subscribes/binding.dart';
import '../modules/details/page.dart';
import '../modules/login/page.dart';
import '../modules/reading/page.dart';
import '../modules/search/page.dart';
import '../modules/shell/page.dart';

part 'routes.dart';

class AppPages {
  static const initial = AppRoutes.shell;

  static final pages = [
    /// Shell
    GetPage(
      name: AppRoutes.shell,
      page: () => const Shell(),
      bindings: [
        ShellBindings(),
        HomeBindings(),
        SubscribesBindings(),
        LoginBindings(),
      ],
    ),

    /// Login
    GetPage(
      name: AppRoutes.login,
      page: () => const Login(),
      bindings: [
        LoginBindings(),
      ],
    ),

    /// Search
    GetPage(
      name: AppRoutes.search,
      page: () => const Search(),
      binding: SearchBindings(),
    ),

    /// Details
    GetPage(
      name: AppRoutes.details,
      page: () => const Details(),
      binding: DetailsBindings(),
      children: [
        /// Reading
        GetPage(
          name: AppRoutes.reading,
          page: () => const Reading(),
          binding: ReadingBindings(),
        ),
      ],
    ),
  ];
}
