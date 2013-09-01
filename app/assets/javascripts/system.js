$(document).on('click.confirmed', '#power-controls .dropdown-menu a', function(e) {
  e.preventDefault();

  if (e.namespace === 'confirmed') {
    $.post($(this).attr('href'), {}, function(data, textStatus, xhr) {
      console.log(data);
    });
  }
});
