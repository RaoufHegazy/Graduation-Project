abstract class fee_login_states {}

class fee_initial_state extends fee_login_states {}


class fee_login_initial_state extends fee_login_states {}
class fee_login_loading_state extends fee_login_states {}
class fee_login_success_state extends fee_login_states {

}
class fee_login_error_state extends fee_login_states {
  final String error;
  fee_login_error_state(this.error);
}

class fee_login_visibility_password_state extends fee_login_states {}




