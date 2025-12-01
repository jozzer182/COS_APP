

import 'main_bloc.dart';

onLoading(
  Loading event,
  emit,
  MainState Function() state,
) {
  emit(
    state().copyWith(
      isLoading: event.isLoading,
    ),
  );
}
