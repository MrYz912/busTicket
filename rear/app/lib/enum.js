function isThisType(val) {
  for (const key in this) {
    if (this[key] == val) {
      return true;
    }
  }
  return false;
}

const LoginType = {
  USER_NICKNAME: "0",
  ADMIN_NICKNAME: "1",
  isThisType,
}

const AuthType = {
  USER: 8,
  ADMIN: 16,
  HIGH_THEN_USER: 9,
}

module.exports = {
  LoginType,
  AuthType
};