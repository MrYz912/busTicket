const Router = require('@koa/router');
const { Auth } = require('../../middlewares/auth');
const { AuthType } = require('../lib/enum');
const { Sequelize } = require('sequelize')
const { sequelize } = require('../../core/db');
const TimeTableModel = require('../../models/timeTable');
const TicketInfoModel = require('../../models/ticketInfo');

const timeTableModel = TimeTableModel(sequelize);
const ticketInfoModel = TicketInfoModel(sequelize);
const router = new Router({
  prefix: '/ticket'
});

router.get('/list', async(ctx, next) => {
  const Op = Sequelize.Op;
  const date = new Date();
  let dateRange = [];
  switch(ctx.query.timeRange) {
    case '0':
      dateRange = ['00:00:00', '24:00:00'];
      break;
    case '1':
      dateRange = ['00:00:00', '06:00:00'];
      break;
    case '2':
      dateRange = ['06:00:00', '12:00:00'];
      break;
    case '3':
      dateRange = ['12:00:00', '18:00:00'];
      break;
    case '4':
      dateRange = ['18:00:00', '24:00:00'];
      break;
    default:
      break;
  }
  const obj = {
    day: new Date(ctx.query.day),
    startStation: ctx.query.startStation,
    endStation: ctx.query.endStation,
    time: {
      [Op.between]: dateRange,
    },
  };
  if (ctx.query.day == date.toLocaleDateString()) {
    obj.time[Op.gt] = date.toLocaleTimeString();
  }
  const order = ctx.query.order;
  let arr= [];
  if (order === 'time+') {
    arr = [['time']];
  } else {
    arr = [['time', 'DESC']];
  }

  let ticketList;
  ticketList = await timeTableModel.findAll({
    attributes: ['id', 'day', 'time', 'startStation', 'endStation', 'money', 'duration', 'count', 'distance'],
    where: obj,
    order: arr,
  });
  if (!ticketList) {
    throw new global.errs.NotFound('车票不存在');
  } else {
    ctx.body = {
      ticketList,
    };
  }
});

router.get('/notUse', new Auth(AuthType.USER).m, async(ctx, next) => {
  const Op = Sequelize.Op;
  const date = new Date();

  const notUseTicket = await ticketInfoModel.findAll({
    attributes: ['id', 'tableId', 'day', 'time', 'startStation', 'endStation', 'money', 'duration', 'riderId', 'riderName', 'riderCreditId'],
    where: {
      userId: ctx.auth.uid,
      [Op.or]: [
        {[Op.and]: [
          { day: date.toLocaleDateString()},
          { time: {[Op.gt]: date.toLocaleTimeString()}},
        ]},
        {
          day: {
            [Op.gt]: date.toLocaleDateString(),
          },
        },
      ],
    },
  });
  ctx.body = {
    notUseTicket,
  };
});

router.get('/allTicket', new Auth(AuthType.USER).m, async(ctx, next) => {
  const allTicket = await ticketInfoModel.findAll({
    attributes: ['id', 'tableId', 'day', 'time', 'startStation', 'endStation', 'money', 'duration', 'riderId', 'riderName', 'riderCreditId'],
    where: {
      userId: ctx.auth.uid,
    },
  });
  ctx.body = {
    allTicket,
  };
})

router.delete('/delete', new Auth(AuthType.USER).m, async(ctx, next) => {
  const tableId = ctx.request.body.tableId;
  const ticketId = ctx.request.body.ticketId;
  const deleteInfo = await ticketInfoModel.destroy({
    where: {
      id: ticketId,
    },
  });
  if (!deleteInfo) {
    throw new global.errs.HttpException('退票失败');
  } else {
    const deleteTable = await timeTableModel.update(
      {count: sequelize.literal('count + 1')},
      {where: {id: tableId}},
    );
    if (!deleteTable) {
      throw new global.errs.HttpException('退票失败');
    } else {
      throw new global.errs.Success();
    }
  }
});

router.post('/change', new Auth(AuthType.USER).m, async(ctx, next) => {
  const { ticketId, tableId, newTableId } = ctx.request.body;

  const tableInfo = await timeTableModel.findOne({
    attributes: [['id', 'tableId'], 'day', 'time', 'startStation', 'endStation', 'money', 'duration'],
    where: {
      id: newTableId,
    },
  });
  const table = tableInfo.dataValues;

  const changeTicket = await ticketInfoModel.update(table, {
    where: {
      id: ticketId,
    },
  });

  const changeTable1 = await timeTableModel.update(
    {count: sequelize.literal('count + 1')},
    {where: {id: tableId}},
  );
  const changeTable2 = await timeTableModel.update(
    {count: sequelize.literal('count - 1')},
    {where: {id: newTableId}},
  );
  throw new global.errs.Success();
})

router.get('/rider', new Auth(AuthType.USER).m, async(ctx, next) => {
  const id = ctx.query.ticketId;
  const riderInfo = await ticketInfoModel.findOne({
    attributes: [['riderId', 'id'], ['riderName', 'name'] ,['riderCreditId', 'creditId']],
    where: {
      id,
    },
  });
  if (!riderInfo) {
    throw new global.errs.HttpException('查询用户失败');
  } else {
    ctx.body = {
      riderInfo,
    }
  }
});

module.exports = router;