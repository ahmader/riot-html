<about>
  <div>
    
    <app-title title="About" sub="{subMenu}"></app-title>
    <a href="#about/credit">credit</a> |
    <a href="#about/copyright">copyright</a>
    <p>{ this.helptext }</p>
    <hr>
    <h2 style="color:teal;text-align:center;">1 image, 3 ways...</h2>
    <div style="display:flex">
      <div style="flex:1">
        <h5>Default Loader</h5>
        <img id="svgdata" alt=""><br>
        <code> &lt;img src="data:... </code>
        <ul>
          <li>Less http requests</li>
          <li><a onmouseover={bgExampleOn} onmouseout={bgExampleOff} style="cursor:pointer">background-image</a></li>
        </ul>
      </div>
      <div style="flex:1">
        <h5>file-loader</h5>
        <img id="svgurl" alt=""><br>
        <code> &lt;img src="img/file.svg </code>
        <ul>
          <li>Traditional way</li>
        </ul>
      </div>
      <div style="flex:1">
        <h5>raw-loader</h5>
        <div id="svginline"></div>
        <code> &lt;svg&gt;...&lt;/svg&gt;</code>
        <ul>
          <li>Hi-Res</li>
          <li>Can 
            <a onmouseover={redrewExampleOn} onmouseout={redrewExampleOff} style="cursor:pointer">redrew</a>, 
            <a onmouseover={transformExampleOn} onmouseout={transformExampleOff} style="cursor:pointer">animate</a>.
          </li>
        </ul>
      </div>
    </div>

  </div>
  

  <script>
    var self = this

    /* Load images as src="data:image/svg+xml;base64,..."  **DEFAULT** */
    import dataLogo from 'Images/logo.svg';
    /* Load load the file as assist. */
    import urlLogo from '!!file-loader?outputPath=img/&mimetype=image/svg+xml!Images/logo.svg';
    /* Load the file as raw like text files. */
    import inlineLogo from '!!raw-loader!Images/logo.svg';
    
    
    self.on('menu', (subMenu) => {
      console.log('about::menu', subMenu);
      self.subMenu=subMenu;
      menuNav();
    });
    
    function menuNav() {
      var id = self.subMenu;
      console.log('route::about:*', id, self.menuId, self.subMenu);
      self.helptext = self.data[id] || self.data.default
      self.currentMenu = id;
      self.tags['app-title'].update({title:'xxx', sub: id});
      self.update({helptext: self.helptext})
    }
    
    // self.aboutRouter = route.create()
    // self.aboutRouter('about/*', menuNav)
    
    self.data = {
      default: 'default about text',
      credit: "This is the [about -> credit] text.",
      copyright: "This is the [about -> copyright] text."
    }
    self.helptext = self.data.default;
    
    self.on('mount', () => {
      if (self.opts.subMenu)
        self.subMenu = self.opts.subMenu;
      console.warn('about______mount', self.opts, self.subMenu);
      menuNav();
      console.warn(urlLogo);
      
      document.getElementById('svginline').innerHTML = inlineLogo;
      document.getElementById('svgurl').src = urlLogo;
      document.getElementById('svgdata').src = dataLogo;
      
      
      // if (self.subMenu) // when subMenu run router to get the view
      // route.exec();
    })
    self.on('update', () => {
      console.warn('about______update', self.subMenu, self.currentMenu);
      if (self.subMenu!=self.currentMenu) {
        menuNav();
      }
    })
    self.on('unmount', () => {
      console.warn('about______unmount');
      // self.aboutRouter.stop();
    })
    self.on('route', function(id) {
      console.log('route::*', id, self);
      self.helptext = "Click the navigation on the left edge."
      self.update()
    })
    self.bgExampleOn = () => {
      document.body.classList.add('svgbg')
    }
    self.bgExampleOff = () => {
      document.body.classList.remove('svgbg')
    }
    self.redrewExampleOn = () => {
      document.getElementsByTagName('svg')[0].style.stroke = 'red';
      document.getElementsByTagName('svg')[0].style.strokeWidth = '3'
    }
    self.redrewExampleOff = () => {
      document.getElementsByTagName('svg')[0].style.stroke = '';
    }
    
    self.transformExampleOn = () => {
      document.querySelector('svg path').style.transform="rotate(45deg)";
      document.querySelector('svg path').style.transformOrigin="center";
    }
    self.transformExampleOff = () => {
      document.querySelector('svg path').style.transform="";
      document.querySelector('svg path').style.transformOrigin="";
    }
  </script>

  <style>
      
  </style>

</about>
