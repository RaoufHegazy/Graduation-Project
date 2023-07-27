import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fee_register_states.dart';

class fee_register_cubit extends Cubit<fee_register_states> {
  fee_register_cubit() : super(fee_register_initial_state());

  static fee_register_cubit get(context) => BlocProvider.of(context);

  // method recieve data when register

  void user_register({
    @required String? name,
    @required String? phone,
    @required String? email,
    @required String? password,
  }) {
    emit(fee_register_loading_state());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      emit(fee_register_success_state());
    }).catchError((error) {
      emit(fee_register_error_state(error.toString()));
    });
  }

// visibility for password
  bool is_password = true;
  IconData suffix = Icons.visibility;
  void fee_register_change_visibility_password() {
    is_password = !is_password;
    suffix = is_password ? Icons.visibility : Icons.visibility_off;
    emit(fee_register_visibility_password_state());
  }
}
