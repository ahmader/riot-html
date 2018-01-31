"use strict"
export default class Family {  
    constructor(_scope, opts) {
      const self = this;
      self.name = 'default family';
      self.opts = opts || {};
      
      // riot.observable(self) // Riot provides our event emitter.
      self.fake_loading = self.opts['fake-loading'] || 0;
      
      self.family = {
        father: self.opts['father'] || 'Mike',
        mother: 'Alice',
        children: [{
          name: 'John',
          gender: 'male'
        },{
          name: 'Sara',
          gender: 'female'
        }]
      }
      console.log('FamilyClass::::::constructor');

    }

}