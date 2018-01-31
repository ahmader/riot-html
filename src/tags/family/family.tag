<family fake-loading="5">
  <app-title title="Family" sub="{subMenu}"></app-title>
  
  <div class="" show={ loading }>
    Loading App this will take {loading} seconds....
  </div>
  
  <div class="" show={ !loading }>
    <div class="">
      <div style="display:inline-block;">Father: <input name="father" class="father" value={this.family.father} onchange={updateFather} oninput={updateFather}></div>
      <div style="display:inline-block;">Mother: <input name="mother" class="mother" value={this.family.mother} onchange={updateMother} oninput={updateMother}></div>
    </div>
    
    
    
    
    <family-status></family-status>
    
    <div class="children">
      <family-child each={child,indexChild in this.family.children}></family-child>
    </div>
    
    <button class="btn-add" type="button" name="button" onclick={addChild}><i class="fa fa-plus"></i> Add</button>
  </div>
  <style media="screen">
    .btn-add {
      font-size: .9em;
      line-height: 1em;
      padding: 5px;
    }
  </style>
  <script>
    var self = this;
    // console.log('family.tag>>>>>start');
    
    // self.opts = Object.assign({
    //   'fake-opts': 'set default opts values'
    // }, self.opts);
    
    import { familySCSS } from './family.scss';
    import Family from './js/family.js';
    
    /* 
      We are not using the RiotControl.
      but the same concept.
    */
    
    
    let myFamily = new Family(self, self.opts)
    myFamily.name = 'Stanford'
    
    self.family = myFamily.family;
    self.loading = myFamily.fake_loading;
    
    import {familyStore} from './js/familystore.js';
    self.store = familyStore;
    self.store.intervalId = 120
    
    
    
    self.genders = ['male', 'female'];
    
    self.on('mount', () => {self.store.intervalId = 300;self.store.trigger('family_init', this.family, self.loading)});
    self.on('unmount', () => self.store.trigger('family_unmount'));
    
    self.updateFather = (e) => self.store.trigger('father_update', e.target.value);
    self.updateMother = (e) => self.store.trigger('mother_update', e.target.value);
    self.addChild = (e) => self.store.trigger('child_add', e.target.value);
    
    
    self.store.on('family_fake_loading', (loading) => {
      console.log('FamilyStore::family_fake_loading', loading);
      self.loading=loading;
      self.update();
    });
    self.store.on('family_changed', (newFamily) => {
      console.log('FamilyStore::family_changed', newFamily);
      self.loading=0;
      self.family=newFamily;
      // self.tags['family-status'].update();
      // familyStore.trigger('children_changed', newFamily);
      self.update();
    });
    
    self.store.on('mother_changed', (newFamily) => {
      // console.log('family.tag>>>>>mother_changed', self.family.mother, newFamily.mother);
    });
    self.store.on('father_changed', (newFamily) => {
      // console.log('family.tag>>>>>father_changed', self.family.father, newFamily.father);
    });
    self.store.on('children_changed', (newFamily) => {
      console.log('family.tag>>>>>children_changed', self.family, newFamily);
    });
    
    
  </script>
</family>