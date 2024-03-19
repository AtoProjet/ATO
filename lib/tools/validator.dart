

String? validateUserName(String name) {
  if (name.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Please enter an email address';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePhone(String phone) {
  if (phone.isEmpty) {
    return 'Please enter a phone number';
  } else if (!RegExp(r'^[+]*[0-9]{10,}$').hasMatch(phone)) {
    return 'Please enter a valid 10-digit phone number';
  }
  return null;
}

String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'Please enter a password';
  } else if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}


