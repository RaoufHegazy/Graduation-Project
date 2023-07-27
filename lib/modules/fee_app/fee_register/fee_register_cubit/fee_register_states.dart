
abstract class fee_register_states {}

class fee_register_initial_state extends fee_register_states {}

class fee_register_loading_state extends fee_register_states {}

class fee_register_success_state extends fee_register_states {}

class fee_register_error_state extends fee_register_states {
  final String? error;

  fee_register_error_state(this.error);
}

class fee_create_user_success_state extends fee_register_states {}

class fee_create_user_error_state extends fee_register_states {
  final String? error;

  fee_create_user_error_state(this.error);
}


class fee_register_visibility_password_state extends fee_register_states {}
