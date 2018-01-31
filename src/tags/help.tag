<help>
  <div>
    <app-title title="App Help" sub="{subMenu}"></app-title>
    <p>{ this.helptext }</p>
    <a href="#help/credit">credit</a> |
    <a href="#help/copyright">copyright</a>
  </div>
  

  <script>
    var self = this
    // console.log(this);
    // import route from 'riot-route/lib/tag';
    
    self.on('menu', (subMenu) => {
      console.log('help::menu', subMenu);
      self.subMenu=subMenu;
      menuNav();
    });
    
    function menuNav() {
      var id = self.subMenu;
      console.log('route::help:*', id, self.menuId, self.subMenu);
      self.helptext = self.data[id] || self.data.default
      self.currentMenu = id;
      self.tags['app-title'].update({title:'xxx', sub: id});
      self.update({helptext: self.helptext})
    }
    // 
    // self.helpRouter = route.create()
    // 
    // self.helpRouter('help/*', function(id) {
    //   console.log('route::help:*', id);
    //   self.helptext = self.data[id] || 'Help not found.'
    //   self.update({helptext: self.helptext})
    // });
    
    self.data = {
      default: 'default help',
      credit: "This is the help for the credit.",
      copyright: "This is the help for the copyright."
    };
    self.helptext = self.data.default;
    self.on('mount', () => {
      if (self.opts.subMenu)
        self.subMenu = self.opts.subMenu;
      console.warn('help______mount');
      // route.exec();
      menuNav();
    });
    self.on('update', () => {
      console.warn('help______update', self.subMenu, self.currentMenu);
      if (self.subMenu!=self.currentMenu) {
        menuNav();
      }
    })
    self.on('unmount', () => {
      console.warn('help______unmount');
      // self.helpRouter.stop();
    });
    self.on('route', function(id) {
      console.log('route::*', id, self);
      self.helptext = "Click the navigation on the left edge."
      self.update()
    });
    
  </script>

  <style scoped=true>
    :scope.appmodal {
      background: #df9191;
    }
    :scope {
      width: 100%;
      height: 100%;
      font-family: sans-serif;
      xpadding: 1em;
      text-align: center;
      color: #666;
      background: #f7f7f7;
      display: block;
    }
    @media (min-width: 480px) {
      :scope {
        /*top: 0;
        right: 0;
        bottom: auto;
        left: auto;
        width: 200px;
        height: 100%;*/
      }
    }
    
  </style>

</help>