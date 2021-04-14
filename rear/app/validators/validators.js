const {
  LinValidator,
  Rule
} = require('../../core/lin-validator-v2')
const {
  LoginType
} = require('../lib/enum');

//注册验证
class RegisterValidator extends LinValidator {
  constructor() {
    super()
    this.password1 = [
      new Rule('isLength', '密码长度必须在6至32位', {
        min: 6,
        max: 32
      }),
      // new Rule('matches', '密码必须包含一个大写字母，一个小写字母，一个数字，一个特殊符号{#?!@$%^&*-}',
      //   '^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]')
    ]
    this.password2 = this.password1
    this.nickname = [
      new Rule('isLength', '昵称长度必须在2至32位', {
        min: 2,
        max: 32
      })
    ]
  }

  validatePassword(vals) {
    const psw1 = vals.body.password1
    const psw2 = vals.body.password2
    if (psw1 !== psw2) {
      throw new Error('两个密码必须相同')
    }
  }
}

// token验证
class TokenValidator extends LinValidator {
  constructor() {
    super();
    this.account = [
      new Rule('isLength', '昵称长度必须在2至32位', {
        min: 2,
        max: 32
      })
    ]
    this.secret = [
      new Rule('isLength', '密码长度必须在6至32位', {
        min: 6,
        max: 32
      }),
      // new Rule('matches', '密码必须包含一个大写字母，一个小写字母，一个数字，一个特殊符号{#?!@$%^&*-}',
      //   '^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]')
    ]
  }

  validateLoginType(val) {
    if (val.body.root !== 0 && val.body.root !== 1) {
      throw new Error('type必须是参数');
    }
    if (!LoginType.isThisType(val.body.root)) {
      throw new Error('type参数不合法');
    }
  }
}

module.exports = {
  RegisterValidator,
  TokenValidator
}