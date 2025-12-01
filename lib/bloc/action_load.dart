import '../resources/future_group_add.dart';
import '../user/controller/user_actions.dart';
import 'action_color.dart';
import 'action_load_data.dart';
import 'main__bl.dart';
import 'func_is_logged.dart';
import 'main_bloc.dart';

onLoad(Bl bl) async {
  MainState Function() state = bl.state;
  print('onLoad');
  FutureGroupDelayed futureGroup = FutureGroupDelayed();
  state().initial();
  bl.startLoading;
  // futureGroup.addF(onCargar2023Loader(bl));
  futureGroup.addF(themeLoader(bl));
  futureGroup.addF(themeColorLoader(bl));
  futureGroup.addF(onCrearUsuario(bl));
  futureGroup.close();
  try {
    await futureGroup.future.then((value) async {
      if (isLogged()) {
        await onLoadData(bl);
      }
    });
  } catch (e) {
    bl.mensaje(message: e.toString());
  }
  bl.stopLoading;
}
