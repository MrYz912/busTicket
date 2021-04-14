const Router = require('@koa/router');
const { Auth } = require('../../middlewares/auth');
const { AuthType } = require('../lib/enum');
const { sequelize } = require('../../core/db');
const AdviceModel = require('../../models/advice');

const adviceModel = AdviceModel(sequelize);
const router = new Router({
  prefix: '/advice'
});

router.post('/', new Auth(AuthType.USER).m, async(ctx, next) => {
  const addAdvice = await adviceModel.create({
    message: ctx.request.body.message,
    userId: ctx.auth.uid,
    userName: ctx.request.body.userName,
    location: ctx.request.body.location,
    time: new Date(ctx.request.body.time),
    phone: ctx.request.body.phone,
  });
  if (!addAdvice) {
    throw new global.errs.HttpException('留言失败');
  } else {
    throw new global.errs.Success();
  }
});

router.get('/list', new Auth(AuthType.USER).m, async(ctx, next) => {
  const pageData = JSON.parse(ctx.query.pageData);
  const limit = pageData.pageSize || 10;
  const offset = (pageData.current - 1) * limit;

  const searchAdvice = await adviceModel.findAndCountAll({
    attributes: ['id', 'message', 'userName', 'location', 'time', 'phone'],
    limit,
    offset,
  });
  ctx.body = {
    searchAdvice,
  }
})

module.exports = router;