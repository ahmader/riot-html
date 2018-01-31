const webpack = require('webpack');
var path = require('path');
var commonConfig = require('./webpack.config.common');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin')
var ExtractTextPlugin = require("extract-text-webpack-plugin");
const extractSass = new ExtractTextPlugin({
  // filename: "css/[name].[contenthash].css",
  filename: "css/style.css",
  disable: process.env.NODE_ENV === "development"
});

var output = {
  path: path.resolve(__dirname, 'public'),
  // publicPath: 'http://www.example.com/build/',
  filename: 'js/bundle.js'
};

module.exports = Object.assign(commonConfig, {
  output: output,
  module: {
    rules: commonConfig.module.rules.concat([{
    test: /\.s?css$/,
      use: extractSass.extract({
        use: [ {
          loader: "css-loader",
          options: { minimize: true }
        }, {
          loader: 'sass-loader',
          options: { minimize: true }
        } ],
        fallback: "style-loader", 
      })
    }])
  },
  plugins: commonConfig.plugins.concat([
    new CleanWebpackPlugin('public'),
    extractSass,
    new webpack.LoaderOptionsPlugin({debug: true}),
    new webpack.optimize.CommonsChunkPlugin('vendor'),
    // new webpack.optimize.DedupePlugin(),
    new UglifyJSPlugin(),
    new webpack.optimize.AggressiveMergingPlugin()
  ])
});