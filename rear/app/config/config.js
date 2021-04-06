module.exports = {
  //prod
  environment: 'dev',
  database: {
    dbName: 'bus_ticket',
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'yangzhen123.'
  },
  security: {
    secretKey: "R!7BWk*0CQ_SCC*behcXws7GtQhpY*Kh",
    expiresIn:60*60*24*90
  }
}