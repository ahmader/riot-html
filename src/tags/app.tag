<app>
  
  <div class="" show={ loading }>
    Loading App this will take {loading} seconds....
  </div>

  <div class="container">
    <family></family>
  </div>
  
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
    
    import FamilyStore from '../stores/familystore.js';
    var familyStore = FamilyStore();
    RiotControl.addStore(familyStore);
    
    import {defaultSettings} from '../js/main.js';
    self.loading=5; // fake loading
    
    // console.log('app.tag>>>>>start', APPVERSION);
    
    this.on('mount', ()=>{
        // console.log('app.tag>>>>>mounted');
        
        var intervalId = setInterval(function() {
            self.loading--;
            // console.log('fake_loading', self.loading);
            if (self.loading==0) {
              clearInterval(intervalId);
              var family = {
                father:'Mike',
                mother: 'Alice',
                children: [{
                  name: 'John',
                  gender: 'male'
                },{
                  name: 'Sara',
                  gender: 'female'
                }]
              };
              self.update();
              return RiotControl.trigger('app_init', family);
              
            }
            self.update();
        }, 1000); // just to see loading in action
        
    });
    
    RiotControl.on('app_ready', (newFamily) => {
      console.log('FamilyStore::app_ready', newFamily);
      RiotControl.trigger('family_changed', newFamily);
    });
    
    // console.log('app.tag>>>>>done');
  </script>
</app>