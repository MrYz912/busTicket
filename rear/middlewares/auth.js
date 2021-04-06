const basicAuth = require('basic-auth');
const jwt = require('jsonwebtoken');

class Auth {
  constructor(level) {
    this.level = level || 1;
  }

  get m() {
    return async (ctx, next) => {
      const token = basicAuth(ctx.req);
      let errMsg = 'token不合法';
      if (!token || !token.name) {
        console.log('进来了');
        throw new global.errs.Forbiden();
      }
      try {
        var decode = jwt.verify(token.name, global.config.security.secretKey);
      } catch (error) {
        if (error.name == 'TokenExpiredError') {
          errMsg = 'token已过期';
        }
        throw new global.errs.Forbiden(errMsg);
      }

      if (decode.scope < this.level) {
        throw new global.errs.Forbiden('权限不足');
      }

      ctx.auth = {
        uid: decode.uid,
        scope: decode.scope,
      };
      await next();
    }
  }
}

module.exports = {
  Auth
};