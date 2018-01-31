// Store definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, an app init.
export default function Store() {
  if (!(this instanceof Store)) return new Store()
  
  riot.observable(this) // Riot provides our event emitter.
  
  var self = this

  self.settings = {
    father: 'Bob',
    mother: null,
    children: []
  };


  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('app_init', function(settings) {
    console.warn('Store::app_init');
    // var cache = JSON.parse(localStorage.getItem('app_cache')) ;
    var cache = false;
    if (settings) self.settings=settings;
    self.trigger('app_ready', cache || self.settings);
  })
  
  // The store emits change events to any listening views, so that they may react and redraw themselves.

}