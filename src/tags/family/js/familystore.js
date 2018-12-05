// https://k94n.com/es6-modules-single-instance-pattern
// FamilyStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of family members.
export function FamilyStore() {
  const self = this;
  if (!(this instanceof FamilyStore)) return new FamilyStore();

  riot.observable(this); // Riot provides our event emitter.

  self.intervalId = null;

  self.family = {
    father: 'Mike',
    mother: 'Alice',
    children: [{
      name: 'John',
      gender: 'male',
    }, {
      name: 'Sara',
      gender: 'female',
    }],
  };

  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('family_init', (family, fakeLoading) => {
    const cache = false;
    // var cache = JSON.parse(localStorage.getItem('app_cache')) ;
    console.warn('FamilyStore::family_init', self, this);

    if (family) self.family = family;

    if (!fakeLoading) {
      console.warn('FamilyStore::-->family_changed', self, this);
      return self.trigger('family_changed', cache || self.family);
    }

    let loading = fakeLoading;
    self.intervalId = setInterval(() => {
      loading -= 1;
      console.log('fakeLoading', loading);
      if (loading <= 0) {
        clearInterval(self.intervalId);
        return self.trigger('family_changed', cache || self.family);
      }
      console.log('send--->family_fakeLoading');
      return self.trigger('family_fakeLoading', loading);
    }, 1000); // just to see loading in action
    return null;
  });
  self.on('family_unmount', () => {
    console.warn('FamilyStore::family_unmount');
    clearInterval(self.intervalId);
  });
  self.on('mother_update', (newMother) => {
    console.warn('FamilyStore::mother_update', self.family, newMother);
    self.family.mother = newMother;
    self.trigger('mother_changed', self.family);
  });

  self.on('father_update', (newFather) => {
    console.warn('FamilyStore::father_update', self.family, newFather);
    self.family.father = newFather;
    self.trigger('father_changed', self.family);
  });

  self.on('child_add', (_newChild) => {
    const newChild = _newChild || { name: '', gender: '' };
    console.warn('FamilyStore::child_add');
    newChild.age = 3600;
    self.family.children.push(newChild);
    self.trigger('children_changed', self.family);
  });

  self.on('child_remove', (childId) => {
    console.warn('FamilyStore::child_remove', childId);
    if (!self.family.children[childId]) return;
    self.family.children.splice(childId, 1);
    self.trigger('family_changed', self.family);
    // self.trigger('children_changed', self.family);
  });


  self.on('child_update', (childId, child) => {
    console.warn('FamilyStore::child_update', childId, child);
    self.family.children[childId] = Object.assign({}, self.family.children[childId], child);
    self.trigger('children_changed', self.family);
  });

  self.on('child_update_gender', (childId, gender) => {
    console.warn('FamilyStore::child_update_gender', childId, gender);
    if (!gender || !self.family.children[childId]) return;
    self.family.children[childId].gender = gender;
    self.trigger('children_changed', self.family);
  });
}

export const familyStore = new FamilyStore();
