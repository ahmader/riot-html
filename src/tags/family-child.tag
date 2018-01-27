<family-child class="child" gender="{child.gender}">
  <div>
    
    <div>
      Child # { this.indexChild } : <input ref="name" class="" name="childName" value="{child.name}" onchange={changeName} oninput={changeName} > 
      <select ref="gender" class="" name="childGender" onchange={changeGender}>
        <option value="" show={!child.gender}></option>
        <option each={gender in this.parent.genders} value={gender} selected={gender==child.gender}>{gender}</option>
      </select>
      child Of: <span class="father">{parent.family.father}</span> and <span class="mother">{parent.family.mother}</span>
      (<span ref="age">{this.age}</span>)
      <button type="button" name="button" onclick={removeChild}><i class="fa fa-close"></i> remove</button>
    </div>
  </div>
  <style media="screen">
    :scope {background: lightgrey; color:black;display:block;padding:10px;margin:10px;}
  </style>
  <script type="text/javascript">
    var self=this;
    // console.log('child.tag>>>>>start', self.indexChild, self.child);
    self.showAlpha = true;
    self.age=self.child.age || 'sticky';
    
    
    this.on('mount', ()=>{
        // console.log('child.tag>>>>>mounted', self.indexChild, self.child);
        if (self.child.age) {
          
          self.interval=setInterval(function () {
            self.age--;
            if (self.age<=0) {
              return self.removeChild();
            }
            // console.log('aging...?');
            self.update();
          }, 1000);
        }
    });
    
    this.on('unmount', ()=>{
        console.log('child.tag>>>>>unmounted', self.indexChild, self.child);
        clearInterval(self.interval);
    });
    self.changeName = (e) => {
      self.child.name=e.target.value;
      self.updateChild();
    }
    self.changeGender = (e) => {
      // RiotControl.trigger('child_update_gender', self.indexChild, e.target.value);
      self.child.gender=e.target.value;
      self.updateChild();
    }
    self.removeChild = () => {
      RiotControl.trigger('child_remove', self.indexChild);
    }
    self.updateChild = () => {
      RiotControl.trigger('child_update', self.indexChild, self.child);
    }
    
    self.selectColor = (c) => {
      console.log('selectColor', c);
    }
    
    // console.log('child.tag>>>>>done');
  </script>
</family-child>