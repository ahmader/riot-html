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
    import Store2 from './js/familystore.js';
    import {familyStore} from './js/familystore.js';
    self.store = familyStore;
    
    self.store = self.parent.store;
    
    // import {myFamily} from './js/family.js';
    self.allFamily = self.store.family;
    
    
    self.status = false;
    console.log('family-status.tag>>>>>start', self.store);
    
    self.store.on('family_changed', (updateFamily) => {
      self.allFamily = updateFamily;
      console.log('family-status:::FamilyStore::family_changed', updateFamily.children);
      self.getStatus();
      self.update();
    });
    
    self.store.on('children_changed', (updateFamily) => {
      self.allFamily = updateFamily;
      console.log('family-status:::FamilyStore::children_changed', updateFamily.children);
      self.getStatus();
      self.update();
    });
    
    self.on('mount', () => {
      // console.log('family-status.tag>>>>>mount', self.store);
    })
    
    self.getStatus = () => {
      // console.log('family-status.tag>>>>>getStatus', self.family);
      if (!self.allFamily) return;
      self.status = {
        count:  self.allFamily.children.length ,
        boys: self.allFamily.children.filter(self.onlyMale).length,
        girls: self.allFamily.children.filter(self.onlyFemale).length
      }
      // self.update();
    }
    
    self.onlyMale = (e) => {
      return e.gender=='male';
    }
    self.onlyFemale = (e) => {
      return e.gender=='female';
    }
    
    // console.log('family-status.tag>>>>>done');
  </script>
</family-status>