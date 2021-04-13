module.exports = {
  configureWebpack: {
    optimization: {
      minimize: false,
    },
  },
  pluginOptions: {
    preload: "src/preload.js",
    electronBuilder: {
      builderOptions: {
        appId: "xyz.calsranna.foxy",
        productName: "Foxy",
        directories: {
          output: "./dist_electron",
        },
        win: {
          target: [
            {
              target: "portable",
              arch: ["x64"],
            },
          ],
        },
      },
      externals: ["knex"],
    },
  },
};
