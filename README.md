# ES6 Riot Starterkit

With this starterkit boilerplate code we want to provide **a simple foundation for Riot applications**.<br>
If you have any ideas on how to improve/simplify the structure you are welcome to help us.

This starterkit is based on:
* [Riot](https://muut.com/riotjs/).
* [RiotControl](https://github.com/jimsparkman/RiotControl/).
* [Sass (CSS with superpowers)](https://github.com/webpack-contrib/sass-loader).
* [Webpack](http://webpack.github.io/).
  
Features:
* Javascript in ES6 using [Babel](https://babeljs.io/).
* Riot tag script in ES6
* Use RiotControl to enable the flux-like app architecture

TODO:
* Use route, view and component to structure the app

Optional Support:
* [bootstrap v4.0.0](https://getbootstrap.com/).
* [font-awesome](http://fontawesome.io/).
* [jQuery](https://jquery.com/).
* [Spectrum (The No Hassle jQuery Colorpicker)](https://bgrins.github.io/spectrum/).
* [jQuery-ui](https://jqueryui.com/).


## Get the kit

```
$ git clone https://github.com/ahmader/riot-html.git && cd riot-html
```


## Installation:

```
$ NODE_ENV=development npm install
```

## Development:
```
$ npm start
```
A server with hot-reload will run at: [http://localhost:3000](http://localhost:3000)

## Building:
```
npm run build
```
A production minified version created at ./public folder


## Extras:

### SimpleHTTPServer :
```
cd public/ && python -m SimpleHTTPServer 3000
```


### Riot:
Riot's default mini-ES6 method syntax cannot work when we are using babel, so we need to change:

```js
// This would not work with babel
buttonHandler(e) {
  // code
}

// Change to this
this.buttonHandler = e => {
  // code
}
```

You don't have to `import 'riot'` everywhere, instead, by using `webpack.ProvidePlugin` it is available everywhere.

To Define global variable with webpack check this 
[stackoverflow](https://stackoverflow.com/a/40416826/1426938).

### jQuery and jquery-ui
Also jQuery is available everywhere, only after you installed it.
```
npm install --save jquery
```
if you want window.$ to be available then add this code to `entry.js`
```js
if (typeof jQuery != 'undefined') {
  // webpack will transpile global. to window.
  global.jQuery = global.jquery = global.$ = jQuery;
}
```

For jquery-ui you can use `jquery-ui` official npm whereby you include what you need to use. (*recommended for size*)

```
npm install --save jquery jquery-ui
```

Then inside any tag
```js
//import $ from 'jquery'; // no need to import jquery as its provided by `webpack.ProvidePlugin`
import 'jquery-ui/themes/base/core.css'; // incase you need the core styles
import 'jquery-ui/themes/base/theme.css'; // incase you need the theme styles
import 'jquery-ui/themes/base/selectable.css'; // incase you need the selectable styles
import 'jquery-ui/ui/widgets/selectable'; // incase you wanted to use $.fn.selectable
import 'jquery-ui/ui/widgets/sortable'; // incase you wanted to use $.fn.sortable
```
Or if your project depend heavily on jquery-ui then use `jquery-ui-dist` where you can import all the library at once. 
[stackoverflow](https://stackoverflow.com/questions/35259835/how-to-import-jquery-ui-using-es6-es7-syntax)

