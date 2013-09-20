$(function() {
  if (location.pathname !== "/addons") { return; }

  var $addons      = $('#addons'),
      addon_source = $('#tmpl-addon').html(),
      template     = Handlebars.compile(addon_source);

  $.getJSON('/addons.json', {}, function(json, textStatus) {
    var addons = { addons: json };
    $addons.html(template(addons));
  });

  $(document).on('click', '.btn.install', function(e) {
    var $addon = $(this).parents('.addon');
    e.preventDefault();

    $.post(this.href, {
      name: $addon.data('name'),
      endpoint: $addon.data('endpoint')

    }, function(data, textStatus, xhr) {
      console.log(data);
    });
  });

});
