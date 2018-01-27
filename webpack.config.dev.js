const webpack = require('webpack');
var path = require('path');
var commonConfig = require('./webpack.config.common');
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var extractCSS = new ExtractTextPlugin('css/style.css');

var output = {
  path: path.resolve(__dirname, 'public'),
  // publicPath: 'http://localhost:8080/build/',
  filename: 'js/bundle.js'
};

module.exports = Object.assign(commonConfig, {
  output: output,
  devtool: 'source-map',
  module: {
    rules: commonConfig.module.rules.concat([{
      test: /\.s?css$/,
      use: extractCSS.extract({
        fallback: "style-loader", 
        use: [{
          loader: "css-loader",
          options: {
            sourceMap: true,
            minimize: false
          }
        }, {
          loader: 'sass-loader',
          options: {
            sourceMap: true,
            minimize: false
          }
        }],
      })
    }])
  },
  plugins: commonConfig.plugins.concat([
    new webpack.LoaderOptionsPlugin({debug: true}),
    extractCSS
  ]),
  devServer: {
    host: "0.0.0.0",
    port: 3000,
    // hot: true,
    contentBase: './public'
  }
});