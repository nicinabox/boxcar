$(document).on('click.confirmed', '#power-controls .dropdown-menu a', function(e) {
  e.preventDefault();
  var $modal = $('#power-modal');
      message = $(this).data('message');

  if (e.namespace === 'confirmed') {
    $.post($(this).attr('href'), {}, function(data, textStatus, xhr) {
      $modal.find('h3').html('The system is ' + message + '.');
      $modal.modal({
        backdrop: 'static',
        keyboard: false
      });
    });
  }
});
