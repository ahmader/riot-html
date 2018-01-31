<app-menu>
  <a each={ links } href="#{ url }" class={ selected: (parent.selectedId === url || (url=='' && parent.selectedId =='home')) }>
    { name }
  </a>

  <script>
    var self = this;
    // import route from 'riot-route/lib/tag';

    
    this.links = self.parent.links
    
    this.on('update', () => {
      self.selectedId = self.parent.selectedId;
      console.log('app-menu--->selectedId', self.selectedId);
    })
    
    
  </script>

  <style>
    :scope {
      position: fixed;
      top: 0;
      left: 0;
      right:0;
      width: : 100%;
      box-sizing: border-box;
      font-family: sans-serif;
      text-align: center;
      color: #666;
      background: #111;
      height: 50px;
      transition: height .2s;
    }
    :scope:hover {
      height: 60px;
    }
    a {
      display: inline-block;
      box-sizing: border-box;
      width: 80px;
      height: 100%;
      line-height: 50px;
      padding: 0 .8em;
      color: white;
      text-decoration: none;
      background: #444;
    }
    a:hover {
      background: #666;
      text-decoration: none;
    }
    a.selected {
      background: teal;
    }
  </style>
</app-menu>