const path = require('path');
const webpack = require('webpack');
const ProvidePlugin = webpack.ProvidePlugin;
const CopyWebpackPlugin = require('copy-webpack-plugin');

const HtmlWebpackPlugin = require('html-webpack-plugin');

const autoprefixer = require('autoprefixer');
const pkg = require('./package.json');  //loads npm config file

const env = process.env.NODE_ENV;
const TARGET = process.env.npm_lifecycle_event;

console.log(env);
console.log("target event is " + TARGET);

var morePlugins=[];
var outputFile = 'bundle.js';

module.exports = {
  cache: false,
  entry: {
    app: "./src/entry.js",
    // vendor  : Object.keys(pkg.dependencies) //get npm vendors deps from config
    vendor  : Object.keys(pkg.dependencies).filter(name => (name != 'font-awesome'))
  },
  module: {
    
    rules: [{
      test: /\.tag$/,
      loader: 'riot-tag-loader',
      enforce: 'pre',  
      query: {
        type: 'es6', // transpile the riot tags using babel
        sourceMap: true
      }
    },{
      test: /\.(js|tag)?$/,
      exclude: /node_modules/,
      use: {
        loader: 'babel-loader',
        query: {
          plugins: ['transform-runtime', "external-helpers-2"],
          presets: ['es2015', "es2015-riot", "stage-0", "stage-2"]
        }
      },
    },{
      test: /\.(jpe?g|png|gif|svg|ttf|eot|woff|woff2)$/,
      exclude: /font\.(ttf|eot|svg|woff|woff2)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      use: [{
        loader: 'url-loader?limit=10000',
        options: {
          // name: '[path][name].[ext]',
          outputPath: 'img/'
        }
      }]
    },{
      test: /font\.(ttf|eot|svg|woff|woff2)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      use: [{
        loader: 'file-loader',
        options: {
          // useRelativePath: true,
          publicPath: '/fonts/',
          outputPath: 'fonts/'
        }
      }]
    }]
  },
  node: {
      fs: "empty" // avoids error messages
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'Webpack Riot es6 html',
      template: './src/index.html', // Load a custom template (lodash by default see the FAQ for details)
      filename: 'index.html',
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name:'vendor',
      filename: 'lib/vendor.min.js'
    }),
    new ProvidePlugin({
      jquery: "jquery",
      $: "jquery",
      jQuery: "jquery"
    }),
    new webpack.ProvidePlugin({
      riot: 'riot',
    }),
    new webpack.ProvidePlugin({
      RiotControl: 'riotcontrol',
    }),
    new webpack.ProvidePlugin({
      RiotRoute: 'riot-route',
    }),
    new webpack.DefinePlugin({
      'APPVERSION':  JSON.stringify(pkg.version)
    }),
  ].concat(morePlugins),
  resolve: { 
    alias: {
      Stores: path.join(__dirname, "src", "stores"),
      Javascripts: path.join(__dirname, "src", "js"),
      Images: path.join(__dirname, "src", "img"),
      // bind version of jquery-ui incase if used jquery-ui-dist *only if we want to add all jquery-ui.
      // 'jquery-ui': 'jquery-ui-dist/jquery-ui.js',
      // bind to modules;
      modules: path.join(__dirname, "node_modules")
    }
  }
};