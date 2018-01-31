/* 
      1. You don't have to import 
        * 'riot'
        * 'riotcontrol'
        * 'riot-hot-reload'
        -> It is available by 'webpack.ProvidePlugin' 
      2. You don't have to include .tag files.
        -> all files in ./tags/*.tag will be included below.
      3. You don't have to import jQuery
        * Just install it
        -> npm install jquery --save
*/


/* importing style files */
import './css/main.scss';
/* Optional style files can be DIRECTLY imported in the main.scss */
/* Tags styles are embeded in the tag folder and need to be imported */


//FIXME find a better way to poplate the router
var g = window || global;
g.route = RiotRoute.default;

/* importing tags */
// require() all files in the tag folder
// NOTE: need to do this, or else mounting the app tag will not mount the child tags
// var context = require.context('./tags/', true, /\.tag$/);
var context = require.context('./tags/', true, /\.tag$/);
context.keys().forEach(key => {
  context(key);
});


console.log('entryjs.start!', APPVERSION);

riot.mount('app', {
  version: APPVERSION
});

console.log( "entryjs.ready!" );
