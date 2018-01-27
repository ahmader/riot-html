<family-status>
  <div class="alert alert-info" style="" show={this.status}>
      Number of Children: { this.status.count },
      Boys: {this.status.boys}
      Girls: {this.status.girls}
  </div>
  <style media="screen">
    
  </style>
  <script>
    var self = this;
    self.status = false;
    // console.log('family-status.tag>>>>>start');
    
    
    RiotControl.on('family_changed', () => {
      console.log('FamilyStore::family_changed', self.parent.family.children);
      self.getStatus();
      self.update();
    });
    
    RiotControl.on('children_changed', () => {
      console.log('FamilyStore::children_changed', self.parent.family.children);
      self.getStatus();
      self.update();
    });
    
    self.on('mount', () => {
      // console.log('family-status.tag>>>>>mount');
    })
    
    self.getStatus = () => {
      // console.log('family-status.tag>>>>>getStatus', self.parent.family);
      if (!self.parent.family) return;
      self.status = {
        count:  self.parent.family.children.length ,
        boys: self.parent.family.children.filter(self.parent.onlyMale).length,
        girls: self.parent.family.children.filter(self.parent.onlyFemale).length
      }
      // self.update();
    }
    // console.log('family-status.tag>>>>>done');
  </script>
</family-status>