<family class="family" show="{this.family!==false}">
  <div class="">
  
    <div style="display:inline-block;">Father: <input name="father" class="father" value={this.family.father} onchange={updateFather} oninput={updateFather}></div>
    <div style="display:inline-block;">Mother: <input name="mother" class="mother" value={this.family.mother} onchange={updateMother} oninput={updateMother}></div>
    
  </div>
  
  <family-status></family-status>
  
  <div class="children">
    <family-child each={child,indexChild in this.family.children}></family-child>
  </div>
  
  <button class="btn-add" type="button" name="button" onclick={addChild}><i class="fa fa-plus"></i> Add</button>
  
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
    self.genders = ['male', 'female'];
    self.family = false;
    
    
    self.on('mount', () => {
      // console.log('family.tag>>>>>mount');
    })
    
    RiotControl.on('family_changed', (newFamily) => {
      console.log('FamilyStore::family_changed', newFamily);
      self.family=newFamily;
      // self.tags['family-status'].update();
      // RiotControl.trigger('children_changed', newFamily);
      self.update();
    });
    
    RiotControl.on('mother_changed', (newFamily) => {
      // console.log('family.tag>>>>>mother_changed', self.family.mother, newFamily.mother);
    });
    RiotControl.on('father_changed', (newFamily) => {
      // console.log('family.tag>>>>>father_changed', self.family.father, newFamily.father);
    });
    RiotControl.on('children_changed', (newFamily) => {
      // console.log('family.tag>>>>>children_changed', self.family, newFamily);
    });
    
    self.onlyMale = (e) => {
      return e.gender=='male';
    }
    self.onlyFemale = (e) => {
      return e.gender=='female';
    }
    
    self.updateFather = (e) => {
      RiotControl.trigger('father_update', e.target.value);
      // self.family.father=e.target.value;
    }
    self.updateMother = (e) => {
      RiotControl.trigger('mother_update', e.target.value);
      // self.family.mother=e.target.value;
    }
    self.addChild = () => {
      RiotControl.trigger('child_add');
      // self.family.children.push({name:'', gender:''})
    }
  </script>
</family>