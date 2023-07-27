import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v46/modules/fee_app/fee_login/cubit_fee_login/fee_login_states.dart';

class fee_login_cubit extends Cubit<fee_login_states> {
  fee_login_cubit() : super(fee_login_initial_state());

  static fee_login_cubit get(context) => BlocProvider.of(context);

  // method recieve data when login

  void user_login({
    @required String? email,
    @required String? password,
  }) {
    emit(fee_login_loading_state());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      emit(fee_login_success_state());
      print(value.user?.email);
    }).catchError((error) {
      emit(fee_login_error_state(error));
    });
  }

// visibility for password
  bool is_password = true;
  IconData suffix = Icons.visibility;
  void fee_login_change_visibility_password() {
    is_password = !is_password;
    suffix = is_password ? Icons.visibility : Icons.visibility_off;
    emit(fee_login_visibility_password_state());
  }
}
