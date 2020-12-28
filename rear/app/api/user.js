const Router = require('@koa/router')
const {
  RegisterValidator
} = require('../validators/validators')
const UserModel = require('../models/user')

const router = new Router({
  prefix: '/user'
})

router.post('/register', async (ctx, next) => {
  const v = await new RegisterValidator().validate(ctx)
  const user = {
    password: v.get('body.password2'),
    nickname: v.get('body.nickname'),
    root: v.get('body.root')
  }
  const r = await UserModel.create(user)
})

module.exports = router