// FamilyStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of family members.
export default function FamilyStore() {
  if (!(this instanceof FamilyStore)) return new FamilyStore()
  
  riot.observable(this) // Riot provides our event emitter.
  
  var self = this

  self.family = {
    father: 'Bob',
    mother: null,
    children: []
  };


  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('app_init', function(family) {
    console.warn('FamilyStore::app_init');
    // var cache = JSON.parse(localStorage.getItem('app_cache')) ;
    var cache = false;
    if (family) self.family=family;
    self.trigger('app_ready', cache || self.family);
  })
  
  self.on('mother_update', function(newMother) {
    console.warn('FamilyStore::mother_update', self.family, newMother);
    self.family.mother=newMother;
    self.trigger('mother_changed', self.family);
  })
  
  self.on('father_update', function(newFather) {
    console.warn('FamilyStore::father_update', self.family, newFather);
    self.family.father=newFather;
    self.trigger('father_changed', self.family);
  })
  
  self.on('child_add', function(newChild) {
    console.warn('FamilyStore::child_add');
    if (!newChild) newChild={name:'', gender:''};
    newChild.age=3600;
    self.family.children.push(newChild);
    self.trigger('children_changed', self.family);
  })
  
  self.on('child_remove', function(childId) {
    console.warn('FamilyStore::child_remove', childId);
    if (!self.family.children[childId]) return;
    self.family.children.splice(childId,1);
    self.trigger('family_changed', self.family);
    // self.trigger('children_changed', self.family);
  })
  
  
  self.on('child_update', function(childId, child) {
    console.warn('FamilyStore::child_update', childId, child);
    self.family.children[childId] = Object.assign({}, self.family.children[childId], child);
    self.trigger('children_changed', self.family);
  })
  
  self.on('child_update_gender', function(childId, gender) {
    console.warn('FamilyStore::child_update_gender', childId, gender);
    if (!gender || !self.family.children[childId]) return;
    self.family.children[childId].gender = gender;
    self.trigger('children_changed', self.family);
  })
  
  
  // The store emits change events to any listening views, so that they may react and redraw themselves.

}