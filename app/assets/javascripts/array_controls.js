$(function() {
  var $array_controls = $('#array-controls');

  $(document).on('click', '#array-controls a', function(e) {
    e.preventDefault();
    var $btn = $(this),
        confirmed = true,
        action = $.trim($btn.text().toLowerCase());

    if ((/stop/).test(action)) {
      confirmed = confirm('Really ' + action + '?');
    }

    if (confirmed) {
      $btn.button('loading');

      var xhr = $.post($(this).attr('href'), {});

      xhr.success(function(data, textStatus, xhr) {
        $array_controls.find('.btn').toggleClass('hide');
        if (window.location.pathname === "/disks") {
          window.reload;
        }
      });

      xhr.complete(function(data, textStatus, xhr) {
        $btn.button('reset');
      });

    }

  });
});
