const {
  LinValidator,
  Rule
} = require('../../core/lin-validator-v2')
const {
  User
} = require('../models/user')

class RegisterValidator extends LinValidator {
  constructor() {
    super()
    this.password1 = [
      new Rule('isLength', '密码长度必须在6至32位', {
        min: 6,
        max: 32
      }),
      new Rule('matches', '密码必须包含一个大写字母，一个小写字母，一个数字，一个特殊符号{#?!@$%^&*-}',
        '^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]')
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

module.exports = {
  RegisterValidator
}