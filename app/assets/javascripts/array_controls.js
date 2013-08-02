$(function() {
  var $array_controls = $('#array-controls');
  var array_started = false;

  if (array_started) {
    $array_controls.find('.btn').toggleClass('hide');
  }

  $(document).on('click', '#array-controls button', function(e) {
    e.preventDefault();
    var $btn = $(this),
        confirmed = true,
        action = $.trim($btn.text().toLowerCase());

    if ((/stop/).test(action)) {
      confirmed = confirm('Really ' + action + '?');
    }

    if (confirmed) {
      $btn.button('loading');

      setTimeout(function () {
        $array_controls.find('.btn').toggleClass('hide');
        $btn.button('reset');
      }, 3000);
    }

  });
});
