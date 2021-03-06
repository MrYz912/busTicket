const Router = require('@koa/router')
const requireDirectory = require('require-directory')

class InitManager {
  static initCore(app) {
    InitManager.app = app
    InitManager.initLoadRouters()
    InitManager.loadConfig();
    InitManager.loadHttpException();
  }

  static loadConfig(path = '') {
    const configPath = path || process.cwd() + '/app/config/config.js'
    const config = require(configPath)
    global.config = config
  }

  static initLoadRouters() {
    const apiDirectory = `${process.cwd()}/app/api`
    requireDirectory(module, apiDirectory, {
      visit: whenLoadModule
    })

    function whenLoadModule(obj) {
      if (obj instanceof Router) {
        InitManager.app.use(obj.routes())
      }
    }
  }

  static loadHttpException() {
    const error = require('./http-exception');
    global.errs = error;
  }
}

module.exports = InitManager