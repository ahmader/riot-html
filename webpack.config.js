const webpack = require('webpack');
var path = require('path');
var commonConfig = require('./webpack.config.common');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin')
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var extractCSS = new ExtractTextPlugin('css/style.css');

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
      use: extractCSS.extract({
        fallback: "style-loader", 
        use: [ {
          loader: "css-loader",
          options: { minimize: true }
        }, {
          loader: 'sass-loader',
          options: { minimize: true }
        } ]
      })
    }])
  },
  plugins: commonConfig.plugins.concat([
    new CleanWebpackPlugin('public'),
    extractCSS,
    new webpack.LoaderOptionsPlugin({debug: true}),
    new webpack.optimize.CommonsChunkPlugin('vendor'),
    // new webpack.optimize.DedupePlugin(),
    new UglifyJSPlugin(),
    new webpack.optimize.AggressiveMergingPlugin()
  ])
});