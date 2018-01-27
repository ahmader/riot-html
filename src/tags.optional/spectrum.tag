<spectrum>  
    <input type="text" name="{opts.name}" value="{opts.color}" ref="colorinput">

    <script>
      var self = this;
      import 'spectrum-colorpicker'; /*  npm install --save spectrum-colorpicker   */
      import 'spectrum-colorpicker/spectrum.css';  
      
      self.getBool = (id, d) => {
        var e = self.getOption(id);
        if (typeof e !='string') return d;
        return (e.toLowerCase()=='true');
      }
      self.getOption = (_id, d) => {
        var id = _id.toLowerCase();
        if (typeof self.opts[id] =='undefined' && d) return d; 
        return self.opts[id];
      }
      
      
      self.on('mount', ()=> {
        var paletteColors=[['red'], ['green'], ['blue']];
        var config = {
            showAlpha: self.getBool('showAlpha', true) ,
            showInput: self.getBool('showInput', true),
            showPalette: self.getBool('showPalette', true),
            preferredFormat: self.getOption('preferredFormat', 'rgb'),
            palette: paletteColors,
            color: self.getOption('color', 'red'),
            move: self.updateBackground
        };
        
        console.log(config);
        
        $(self.refs.colorinput).spectrum(config);
        
      })
      
      self.updateBackground = (e) => {
        var color = (e instanceof tinycolor) ? e.toRgbString() : '';
        var onupdate = self.opts.onupdate;
        console.warn('updateBackground!', color, typeof onupdate);
        if (onupdate && typeof onupdate =='function')
          onupdate(color)
        return color;
      }
    </script>
</spectrum>