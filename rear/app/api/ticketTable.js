const Router = require('@koa/router');
const { Auth } = require('../../middlewares/auth');
const { AuthType } = require('../lib/enum');
const { Sequelize } = require('sequelize')
const { sequelize } = require('../../core/db');
const TimeTableModel = require('../../models/timeTable');

const timeTableModel = TimeTableModel(sequelize);
const router = new Router({
  prefix: '/ticketTable'
});

router.get('/list', new Auth(AuthType.ADMIN).m, async(ctx, next) => {
  const formInline = JSON.parse(ctx.query.formInline);
  const pageData = JSON.parse(ctx.query.pageData);
  const limit = pageData.pageSize || 10;
  const offset = (pageData.current - 1) * limit;

  const tableList = await timeTableModel.findAndCountAll({
    attributes: ['id', 'day', 'time', 'startStation', 'endStation', 'money', 'duration', 'count', 'distance'],
    // order: [
    //   ['day'],
    //   ['time'],
    // ],
    where: formInline,
    limit,
    offset,
  });
  ctx.body = {
    tableList,
  };
});

router.post('/edit', new Auth(AuthType.ADMIN).m, async(ctx, next) => {
  const data = ctx.request.body;
  const editTable = await timeTableModel.update(
    data,
    {where: {id: data.id}},
  );
  if (!editTable) {
    throw new global.errs.HttpException('更新失败');
  } else {
    throw new global.errs.Success();
  }
});

router.post('/create', new Auth(AuthType.ADMIN).m, async(ctx, next) => {
  const data = ctx.request.body;
  const createTable = await timeTableModel.create(data);
  if (!createTable) {
    throw new global.errs.HttpException('新增失败');
  } else {
    throw new global.errs.Success();
  }
})

router.delete('/delete', new Auth(AuthType.ADMIN).m, async(ctx, next) => {
  const deleteTable = await timeTableModel.destroy({
    where: {
      id: ctx.request.body.id,
    },
  });
  if (!deleteTable) {
    throw new global.errs.HttpException('删除失败');
  } else {
    throw new global.errs.Success();
  }
});

module.exports = router;