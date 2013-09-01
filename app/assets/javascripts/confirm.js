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

$(document).on('click', '[data-confirm]', function(e) {
  var message = $(this).data('confirm'),
      confirmed = confirm(message);

  if (confirmed) {
    $(this).trigger('click.confirmed');
  } else {
    return false;
  }
});
