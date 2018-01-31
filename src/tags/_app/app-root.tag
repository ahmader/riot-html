<app-root>
  <div ref="container" class="container" style="padding-top:60px;">
    
  </div>
  <script>
    
    var self = this;
    console.warn('app-root:start');
    self.on('mount', () => {
      console.log('app-root:::mount');
      route.start(true);
      // route.exec();
    });
    self.on('unmount', () => {
      console.log('app-root:::unmount');
    });
    self.on('update', () => {
      console.log('app-root:::update');
      // console.log(self.tags);
      // console.log(self.refs.container);
    });
    self.loadApp = (menuId, subMenu) => {
      var menuOptions = self.getMenuOptions(menuId);
      if (!menuOptions) {
        menuOptions={};
        menuId='app-404';
      }
      var oldId = self.selectedId;
      var isSameApp = (menuId==oldId);
      
      console.warn(`loadApp old(${oldId}) new(${menuId})`, menuOptions );
      if (self.oldApp && !isSameApp) self.oldApp[0].unmount(false);
      
      
      self.selectedId = menuId
      self.parent.selectedId = menuId
      self.parent.subMenuId = subMenu;
    
      
      
      if (isSameApp) {
        console.log('SKIP:::SKIP::::SKIP');
        self.oldApp[0].trigger('menu', subMenu); 
        // self.oldApp[0].update({menuId: menuId, subMenu:subMenu});
        return;
      }
      
      
      
      var opts = menuOptions.data || {};
      opts.subMenu = subMenu;
      self.refs.container.innerHTML = `<${menuId} ref="apppp"/>`;
      self.oldApp = riot.mount(menuId, opts);
      
      
      RiotControl.trigger('app_menu', menuId); 
      
      console.log('app-root::::update:::update::::update');
      self.update();
    }
    
    var routes = []
    self.parent.links.map(l => {
      if (l.links) {
        l.links.map(s => {
            routes.push(s.url);
        })
      }
      routes.push(l.url);
    })
    console.log(routes);
    var r = route.create()
    r(highlightCurrent)
    function highlightCurrent(menuId, subMenu){
      if (!menuId) menuId='home';
      console.log('menuCurrent', menuId, subMenu);
      self.loadApp(menuId, subMenu)

      // self.tags['app-menu'].update({selectedId: menuId})
      // self.update();
    }
    
    self.getMenuOptions = mId => self.parent.links.slice(0).find(l => (l.url=='' && mId=='home') || (l.url==mId) );
    
    window.addEventListener("message", receiveMessage, false);

    function receiveMessage(event)
    {
      console.log('==============================receiveMessage', event.data);
      if (event.data.type=='app-modal-nav')
      document.getElementById('fra').setAttribute('src', 'modal.html'+event.data.url)
    }
    
    RiotControl.on('app_modal', (e) => {
      var uri = e.url.split('/');
      var menuId = uri.shift();
      var subMenu = uri.shift();
      console.log('~~~~~~~~~~~~~~~~~~~~>>>>>app_modal', e, menuId, subMenu);
      self.loadApp(menuId, subMenu);
    })
    console.log('app.root>>>>>done');
    
  </script>
</app-root>