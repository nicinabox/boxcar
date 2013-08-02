//= require bootstrap
//= require array_controls

$(function() {
  $('[data-toggle=tooltip]').tooltip();
});

$(document).on('click', '[data-method]', function(e) {
  var confirmed = true;

  if ($(this).data('method') === 'delete') {
    confirmed = confirm("Really delete this " + $(this).data('model') + '?');
  }

  if (confirmed) {
    $(this.form).find('[name=_method]').val($(this).data('method'));
  } else {
    e.preventDefault();
  }
});
