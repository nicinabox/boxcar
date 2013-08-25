$(function() {
  var $addons = $('#addons');

  $.getJSON('/addons.json', {}, function(json, textStatus) {
    html = ''

    $.each(json, function(index, addon) {
      html += ''+
        '<div class="addon" id="addon_' + addon.id + '">' +
          '<h2>' + addon.name + ' <small>' + addon.latest_version.version + '</small></h2>' +
          '<p class="lead">' + addon.latest_version.description + '</p>' +
        '</div>';
    });

    $addons.html(html);
  });

});
