<jqueryui-dialog>
  <div id="dialog" title="Basic dialog">
    <p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
  </div>
  <script>
    var self=this;
    /*  npm install --save jquery/jquery-ui       */
    import "jquery-ui/ui/widgets/dialog";
    import 'jquery-ui/themes/base/all.css';      
    
    self.on('mount', () => {
      $( "#dialog" ).dialog();
    })
  </script>
</jqueryui-dialog>