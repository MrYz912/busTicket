const Router = require('@koa/router');
const { sequelize } = require('../../core/db');
const { Auth } = require('../../middlewares/auth');
const { AuthType } = require('../lib/enum');
const User2RiderModel = require('../../models/user2rider');
const RiderModel = require('../../models/rider');

const user2RiderModel = User2RiderModel(sequelize);
const riderModel = RiderModel(sequelize);
const router = new Router({
  prefix: '/passenger'
});

router.get('/list', new Auth(AuthType.USER).m, async(ctx, next) => {
  const list = await user2RiderModel.findAll({
    attributes: ['riderId', 'name', 'creditId'],
    where: {
      userId: ctx.auth.uid,
    },
  });
  if (!list) {
    throw new global.errs.NotFound('没有乘车人');
  } else {
    ctx.body = {
      list,
    };
  }
});

router.post('/create', new Auth(AuthType.USER).m, async(ctx, next) => {
  const rider = {
    name: ctx.request.body.name,
    creditId: ctx.request.body.creditId
  };
  const createRider = await riderModel.create(rider);
  if (!createRider) {
    throw new global.errs.HttpException('新增失败');
  } else {
    const u2r = {
      userId: ctx.auth.uid,
      riderId: createRider.dataValues.id,
      creditId: ctx.request.body.creditId,
      name: ctx.request.body.name,
    }
    const createU2R = await user2RiderModel.create(u2r);
    if (!createU2R) {
      throw new global.errs.HttpException('新增失败');
    } else {
      throw new global.errs.Success();
    }
  }
});

router.post('/edit', new Auth(AuthType.USER).m, async(ctx, next) => {
  const riderId = ctx.request.body.id;
  const rider = {
    name: ctx.request.body.name,
    creditId: ctx.request.body.creditId,
  };
  const editRider = await riderModel.update(rider, {
    where: {
      id: riderId,
    },
  });
  if (!editRider) {
    throw new global.errs.HttpException('修改失败');
  } else {
    const editU2R = await user2RiderModel.update(rider, {
      where: {
        userId: ctx.auth.uid,
        riderId,
      },
    });
    if (!editU2R) {
      throw new global.errs.HttpException('修改失败');
    } else {
      throw new global.errs.Success();
    }
  }
});

router.delete('/delete', new Auth(AuthType.USER).m, async(ctx, next) => {
  const riderId = ctx.request.body.id;
  const userId = ctx.auth.uid;
  const deleteRider = await riderModel.destroy({
    where: {
      id: riderId,
    },
  });
  if (!deleteRider) {
    throw new global.errs.HttpException('删除失败');
  } else {
    const deleteU2R = await user2RiderModel.destroy({
      where: {
        riderId,
        userId,
      },
    });
    if (!deleteU2R) {
      throw new global.errs.HttpException('删除失败');
    } else {
      throw new global.errs.Success();
    }
  }
});

module.exports = router;