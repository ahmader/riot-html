// Store definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, an app init.
export default function Store() {
  const self = this;
  if (!(this instanceof Store)) return new Store();

  riot.observable(this); // Riot provides our event emitter.

  self.settings = {
    father: 'Bob',
    mother: null,
    children: [],
  };


  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('app_init', (settings) => {
    const cache = false;
    console.warn('Store::app_init');
    // var cache = JSON.parse(localStorage.getItem('app_cache')) ;
    if (settings) self.settings = settings;
    self.trigger('app_ready', cache || self.settings);
  });
}
