const Router = require('@koa/router');
const { sequelize } = require('../../core/db');
const CityModel = require('../../models/city');
const BusStationModel = require('../../models/busStation');

const cityModel = CityModel(sequelize);
const busStationModel = BusStationModel(sequelize);
const router = new Router({
  prefix: '/cityStation'
});

router.get('/city', async(ctx, next) => {
  let city = await cityModel.findAll({
    attributes: ['id', ['cityName', 'text']],
  });
  if (!city) {
    throw new global.errs.NotFound('城市不存在');
  } else {
    ctx.body = {
      city,
    }
  }
})

router.get('/station', async(ctx, next) => {
  const station = await busStationModel.findAll({
    attributes: ['id', ['station', 'text']],
    where: {
      cityId: ctx.query.id
    }
  });
  if (!station) {
    throw new global.errs.NotFound('汽车站不存在');
  } else {
    ctx.body = {
      station,
    }
  }
})

module.exports = router;