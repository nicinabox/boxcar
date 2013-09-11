$(function() {
  if (location.pathname !== "/addons") { return; }

  var $addons = $('#addons');

  $.getJSON('/addons.json', {}, function(json, textStatus) {
    var html = '';

    $.each(json, function(index, addon) {
      html += ''+
        '<div class="addon row" id="addon_' + addon.index + '" data-name="' + addon.name + '" data-endpoint="' + addon.endpoint + '">' +
          '<div class="col-sm-10">' +
            '<h2>' + addon.name + ' <small>' + addon.latest.number + '</small></h2>' +
            '<p class="lead">' + addon.latest.description + '</p>' +
          '</div>' +
          '<div class="col-sm-2">' +
            '<a href="/addons/install/" class="btn btn-primary install">Install</a>' +
          '</div>' +
        '</div>' +
        '<hr>';
    });

    $addons.html(html);
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
