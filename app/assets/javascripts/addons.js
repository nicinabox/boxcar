if (location.pathname !== "/addons") { return; }

$(function() {
  var $addons      = $('#addons'),
      addon_source = $('#tmpl-addon').html(),
      template     = Handlebars.compile(addon_source);

  // Get all addons
  $.getJSON('/addons.json', {}, function(addons, textStatus) {
    var html = '';

    $.each(addons, function(i) {
      html += template(this);
    });

    $addons.html(html);
  });

  // Install handler
  $(document).on('submit', 'form.addon', function(e) {
    e.preventDefault();

    var $install_btn = $(this).find('.install');

    $install_btn.button('loading');

    $.post(this.action, $(this).serialize(), function(data, textStatus, xhr) {
      $install_btn.button('reset');
      $install_btn.text('Remove')
                  .toggleClass('btn-primary btn-danger install remove');
    });
  });

});
