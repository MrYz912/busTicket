const Router = require('@koa/router');
const { RegisterValidator } = require('../validators/validators');
const { sequelize } = require("../../core/db");
const UserModel = require('../../models/user');

const userModel = UserModel(sequelize);
const router = new Router({
  prefix: '/admin'
});

// 注册接口
router.post('/register', async (ctx) => {
  const v = await new RegisterValidator().validate(ctx);
  const user1 = await userModel.findOne({
    where: {
      nickname: v.get('body.nickname'),
      root: 1,
    }
  });
  // 如果已经存在
  if (user1) {
    throw new global.errs.AuthFailed('用户已存在');
  } else {
    const user = {
      password: v.get('body.password2'),
      nickname: v.get('body.nickname'),
      root: 1,
    };
    const r = await userModel.create(user);
    //返回成功
    throw new global.errs.Success();
  }
});

module.exports = router;