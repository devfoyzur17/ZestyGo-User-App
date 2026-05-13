class ResetPasswordRequestModel {
  String? resetToken;
  String? newPassword;
  String? confirmPassword;

  ResetPasswordRequestModel({
    this.resetToken,
    this.newPassword,
    this.confirmPassword,
  });

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    resetToken = json['reset_token'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reset_token'] = resetToken;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
