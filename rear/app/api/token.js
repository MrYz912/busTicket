const Router = require('@koa/router');
const bcryptjs = require('bcryptjs');
const { LoginType, AuthType } = require('../lib/enum');
const { TokenValidator} = require('../validators/validators');
const { sequelize } = require("../../core/db");
const { generateToken } = require('../../core/util');
const UserModel = require('../../models/user');

const userModel = UserModel(sequelize);
const router = new Router({
  prefix: '/token'
});

router.post('/', async (ctx) => {
  const v = await new TokenValidator().validate(ctx);
  let token;
  switch (v.get('body.root')) {
    case LoginType.USER_NICKNAME:
      token = await login(v.get('body.account'), v.get('body.secret'), AuthType.USER);
      break;
    case LoginType.ADMIN_NICKNAME:
      token = await login(v.get('body.account'), v.get('body.secret'), AuthType.ADMIN);
      break;
    default:
      throw new global.errs.ParameterException('没有相应的处理函数');
  }
  ctx.body = {
    token,
    name: v.get('body.account'),
  }
  // throw new global.errs.Success();
});

async function login(account, secret, type) {
  const user = await userModel.findOne({
    where: {
      nickname: account
    }
  });
  if (!user) {
    throw new global.errs.NotFound('用户不存在');
  }
  const correct = bcryptjs.compareSync(secret, user.password);
  if (!correct) {
    throw new global.errs.AuthFailed('密码不正确');
  }
  return token = generateToken(user.userId, type);
}

module.exports = router, { login };