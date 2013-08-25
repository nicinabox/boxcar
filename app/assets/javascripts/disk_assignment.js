$(function() {
  var $disks = $('#disks');

  $(document).on('change', '#disks select', function() {
    var $select_fields = $disks.find('select');

    // start by setting everything to enabled
    $select_fields.find('option').attr('disabled',false).show();

    // loop each select and set the selected value to disabled in all other selects
    $select_fields.each(function(){
        var $this = $(this);
        $select_fields.not($this).find('option').each(function(){
           if($(this).attr('value') == $this.val())
               $(this).attr('disabled',true).hide();
        });
    });
  });
});
