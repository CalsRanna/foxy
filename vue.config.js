// const TerserPlugin = require("terser-webpack-plugin");
module.exports = {
  configureWebpack: {
    optimization: {
      minimize: false
    }
  },
  pluginOptions: {
    electronBuilder: {
      builderOptions: {
        appId: "xyz.calsranna.foxy",
        productName: "Foxy",
        directories: {
          output: "./dist_electron"
        },
        win: {
          target: [
            {
              target: "portable",
              arch: ["x64"]
            }
          ]
        }
      }
    }
  }
};
