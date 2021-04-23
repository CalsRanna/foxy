const path = require("path");
const rollup = require("rollup");
const argv = require("minimist")(process.argv.slice(2));
const chalk = require("chalk");
const ora = require("ora");
const waitOn = require("wait-on");
const electron = require("electron-connect").server.create({
  logLevel: 0,
  stopOnClose: true,
});
require("dotenv").config({ path: path.join(__dirname, "../.env") });
const options = require("./rollup.config");
const net = require("net");
const { URL } = require("url");

const opt = options(argv.env);
const TAG = "[script/build.js]";
const spinner = ora(`${TAG} main process build started`);

const watchFunc = function () {
  const watcher = rollup.watch(opt);
  watcher.on("change", (filename) => {
    const log = chalk.green(`${filename} changed`);
    console.log(log);
    console.log(TAG, "reloading electron");
  });
  watcher.on("event", (ev) => {
    if (ev.code === "END") {
      electron.electronState === "init" ? electron.start() : electron.restart();
    } else if (ev.code === "ERROR") {
      console.log(ev.error);
    }
  });
};

const resource = `http://localhost:${process.env.PORT}/index.html`;

if (argv.watch) {
  waitOn(
    {
      resources: [resource],
      timeout: 5000,
    },
    (err) => {
      if (err) {
        const { port, hostname } = new URL(resource);
        const serverSocket = net.connect(port || 80, hostname, () => {
          watchFunc();
        });
        serverSocket.on("error", (e) => {
          console.log(err);
          process.exit(1);
        });
      } else {
        watchFunc();
      }
    }
  );
} else {
  spinner.start();
  rollup
    .rollup(opt)
    .then((build) => {
      spinner.stop();
      console.log(chalk.green("main process build successed"));
      build.write(opt.output);
    })
    .catch((error) => {
      spinner.stop();
      console.log(
        `${chalk.red("main process build failed")}\n`,
        `${chalk.red(error)}\n`
      );
    });
}
