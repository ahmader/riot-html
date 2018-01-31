<home>
  <app-title title="Home" sub="{subMenu}"></app-title>
  <script>
    var self = this;
    self.on('mount', () => {
      console.log('home:::mount');
    });
    self.on('unmount', () => {
      console.log('home:::unmount');
    });
  </script>
</home>