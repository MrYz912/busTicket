const Router = require('@koa/router');
const { Auth } = require('../../middlewares/auth');
const { AuthType } = require('../lib/enum');
const { sequelize } = require('../../core/db');
const TimeTableModel = require('../../models/timeTable');
const TicketInfoModel = require('../../models/ticketInfo');
const RiderModel = require('../../models/rider');

const timeTableModel = TimeTableModel(sequelize);
const ticketInfoModel = TicketInfoModel(sequelize);
const riderModel = RiderModel(sequelize);
const router = new Router({
  prefix: '/pay'
});

router.post('/', new Auth(AuthType.USER).m, async(ctx, next) => {
  const userId = ctx.auth.uid;
  const passenger = ctx.request.body.passengerId;
  const len = passenger.length;
  const ticketId = ctx.request.body.ticketId;
  
  const searchTable = await timeTableModel.findOne({
    attributes: ['day', 'time', 'startStation', 'endStation', 'money', 'duration'],
    where: {
      id: ticketId,
    }
  });
  const tableDate = searchTable.dataValues;
  let arr = [];
  for(let i = 0; i < len; i++) {
    const searchRider = await riderModel.findOne({
      attributes: ['id', 'name', 'creditId'],
      where: {
        id: passenger[i],
      }
    });
    let obj = {};
    obj = {
      tableId: ticketId,
      day: tableDate.day,
      time: tableDate.time,
      startStation: tableDate.startStation,
      endStation: tableDate.endStation,
      userId,
      money: tableDate.money,
      duration: tableDate.duration,
      riderId: searchRider.dataValues.id,
      riderName: searchRider.dataValues.name,
      riderCreditId: searchRider.dataValues.creditId,
    }
    arr.push(obj);
  }

  const ticketInfo = await ticketInfoModel.bulkCreate(arr);

  const timeTable = await timeTableModel.update(
    {count: sequelize.literal('count - ' + len)},
    {where: { id: ticketId } },
  );
  if (!searchTable || !ticketInfo || !timeTable) {
    throw new global.errs.HttpException();
  }
  throw new global.errs.Success();
})

module.exports = router;