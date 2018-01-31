<app>
  
  <app-menu />
  
  
    <app-root ></app-root>
    <!--router>
      <route path="family"><family /></route>
      <route path="about"><about /></route>
      <route path="*">unknown</route>
      <route path=""><h1>home</h1></route>
    </router-->
    
  <!-- 
  
    OPTIONAL TAGS 
      ./tags.optional/
      
  -->
  
  <spectrum onupdate={selectColor} color="blue" showalpha="false">
    <!-- 
      USAGE:
        $ npm install --save spectrum-colorpicker
        $ mv ./tags.optional/spectrum.tag ./tags
    -->
  </spectrum>
  
  <jqueryui-dialog>
    <!-- 
      USAGE:
        $ npm install --save jquery/jquery-ui
        $ mv ./tags.optional/jqueryui-dialog.tag ./tags
    -->
  </jqueryui-dialog>
  
  <hr>
  
  <div class="app-footer">  
    <a href="https://github.com/ahmader" target="_blank"  style="">v{opts.version} <i class="fa fa-code bold"></i> with <i class="fa fa-heart"></i> by @Ahmader</a>
  </div>
  <style media="screen">
    .app-footer a{color:gray;text-decoration: none;font-size:12px;line-height:14px;}
    .app-footer a:hover{color:darkgray;text-decoration: underline;}
    .fa {vertical-align: middle;}
  </style>
  <script>
    var self=this;
    // import route from 'riot-route/lib/tag';
    import Store from 'Stores/_store.js';
    var appControl = Store();
    RiotControl.addStore(appControl);
  
    import {defaultSettings} from 'Javascripts/main.js';
    
    self.links = [
      { name: "Home", url: "" },
      { name: "Family", url: "family", data: {'fake-loading': 3, father:'Bob'} },
      { name: "About", url: "about", links: [
        { name: "copyright", url: "about/copyright" },
        { name: "credit", url: "about/credit" },
      ] },
      { name: "?", url: "help" }
    ]
    
    // console.log('app.tag>>>>>start', APPVERSION);
    
    this.on('mount', ()=>{
        // console.log('app.tag>>>>>mounted');
        return appControl.trigger('app_init');        
    });
    appControl.on('app_menu', (menuId) => {
      console.log('Store::app_menu', self.selectedId);
      self.tags['app-menu'].update();
    });
    appControl.on('app_ready', () => {
      console.log('Store::app_ready');
      // appControl.trigger('family_changed', newFamily);
    });
    
    console.log('app.tag>>>>>done');
  </script>
</app>