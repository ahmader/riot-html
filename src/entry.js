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


/* importing tags */
// require() all files in the tag folder
// NOTE: need to do this, or else mounting the app tag will not mount the child tags
var context = require.context('./tags/');
context.keys().forEach(key => {
  context(key);
});


/* importing style files */
import './css/main.scss';
/* Optional style files can be DIRECTLY imported in the main.scss */


/* if you install jquery library, then jQuery variable will be defined */
/*  npm install --save jquery */
if (typeof jQuery != 'undefined') {
  global.jQuery = global.jquery = global.$ = jQuery; // this will transpile to window.$
}


console.log('entryjs.start!', APPVERSION);


riot.mount('app', {
  version: APPVERSION
});

console.log( "entryjs.ready!" );
