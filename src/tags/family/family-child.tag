<family-child class="child" gender="{child.gender}">
  <div>
    
    <div>
      Child # { this.indexChild+1 } : <input ref="name" class="" name="childName" value="{child.name}" onchange={changeName} oninput={changeName} > 
      <select ref="gender" class="" name="childGender" onchange={changeGender}>
        <option value="" show={!child.gender}></option>
        <option each={gender in this.parent.genders} value={gender} selected={gender==child.gender}>{gender}</option>
      </select>
      child Of: <span class="father">{myParentFamily.father}</span> and <span class="mother">{myParentFamily.mother}</span>
      (<span ref="age">{this.age}</span>)
      <button type="button" name="button" onclick={removeChild}><i class="fa fa-close"></i> remove</button>
    </div>
  </div>
  <style media="screen">
    :scope {background: lightgrey; color:black;display:block;padding:10px;margin:10px;}
  </style>
  <script type="text/javascript">
    var self=this;
    
    import {familyStore} from './js/familystore.js';
    let myStore = familyStore;
    self.myParentFamily = myStore.family;
    
    // import {myFamily} from './js/family.js';
    // self.myParentFamily = myFamily.family;
    
    self.age=self.child.age || 'sticky';
    
    
    this.on('mount', ()=>{
        // console.log('child.tag>>>>>mounted', self.indexChild, self.child);
        if (self.child.age) {
          
          self.interval=setInterval(function () {
            self.age--;
            if (self.age<=0) {
              return self.removeChild();
            }
            console.log('aging...?');
            self.update();
          }, 1000);
        }
    });
    
    this.on('unmount', ()=>{
        console.log('child.tag>>>>>unmounted', self.indexChild, self.child);
        clearInterval(self.interval);
    });
    myStore.on('family_changed', (updateFamily) => {
      self.myParentFamily = updateFamily;
      self.update();
    });
    
    self.changeName = (e) => {
      self.child.name=e.target.value;
      self.updateChild();
    }
    self.changeGender = (e) => {
      self.child.gender=e.target.value;
      self.updateChild();
    }
    self.removeChild = () => {
      myStore.trigger('child_remove', self.indexChild);
    }
    self.updateChild = () => {
      myStore.trigger('child_update', self.indexChild, self.child);
    }
    
    // console.log('child.tag>>>>>done');
  </script>
</family-child>