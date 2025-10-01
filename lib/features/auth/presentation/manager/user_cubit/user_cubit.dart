import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:member360/features/auth/data/models/user_model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  void onUpdateUserData(UserModel model) {
    emit(UserUpdateState(model: model, changed: !state.changed));
  }
}
