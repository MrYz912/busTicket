const Koa = require('koa')
const bodyParser = require('koa-bodyparser')
const InitManager = require('./core/init')
const catchError = require('./middlewares/exception')
const cors = require('koa2-cors');

const app = new Koa()

app.use(bodyParser())
app.use(
  cors({
    origin: (ctx) =>{
      // const whiteList = ['http://localhost:9091','http://localhost:8080']; //可跨域白名单
      // let url = ctx.header.referer.substr(0,ctx.header.referer.length - 1);
      // if(whiteList.includes(url)){
      //   return url //注意，这里域名末尾不能带/，否则不成功，所以在之前我把/通过substr干掉了
      // }
      // return 'http://localhost:3000' //默认允许本地请求3000端口可跨域
      return '*';
    },
    maxAge: 5, //指定本次预检请求的有效期，单位为秒。
    credentials: true, //是否允许发送Cookie
    allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], //设置所允许的HTTP请求方法
    allowHeaders: ['Content-Type', 'Authorization', 'Accept'], //设置服务器支持的所有头信息字段
    exposeHeaders: ['WWW-Authenticate', 'Server-Authorization'] //设置获取其他自定义字段
  })
);
app.use(catchError)
InitManager.initCore(app)
app.listen(3000)