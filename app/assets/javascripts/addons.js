$(function() {
  if (location.pathname !== "/addons") { return; }

  var $addons      = $('#addons'),
      addon_source = $('#tmpl-addon').html(),
      template     = Handlebars.compile(addon_source);

  $.getJSON('/addons.json', {}, function(json, textStatus) {
    var addons = { addons: json };
    console.log(addons)
    $addons.html(template(addons));
  });

  $(document).on('click', '.btn.install', function(e) {
    e.preventDefault();
    $.post(this.href, {
      name: $(this).parents('.addon').data('name'),
      endpoint: $(this).parents('.addon').data('endpoint')
    }, function(data, textStatus, xhr) {
      console.log(data)
    });
  });

});
