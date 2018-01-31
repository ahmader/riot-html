<app-title sub="false">
    <h1>
      <span>{pageTitle.toUpperCase()}</span>
      <span show="{pageSub}"> <i class="fa fa-arrow-right"></i> {pageSub}</span>
    </h1>
    <script>
      var self = this;
      self.pageTitle = self.opts.title || '';
      self.pageSub = self.opts.sub || '';
      self.on('mount', ()=> {
        // console.warn('app-title:::mount');
        // console.log('pageTitle',self.pageTitle, self.opts.title);
        // console.log('pageSub', self.pageSub, self.opts.sub);
        if (self.pageTitle != self.opts.title || (self.opts.sub && self.pageSub != self.opts.sub))
          self.update();
      });
      self.on('unmount', ()=> {
        console.warn('app-title:::unmount');
      });
      self.on('update', ()=> {
        // console.warn('app-title:::update');
        self.pageTitle = self.opts.title || '';
        self.pageSub = self.opts.sub || '';
      });
    </script>
    <style>
      
    </style>
</app-title>