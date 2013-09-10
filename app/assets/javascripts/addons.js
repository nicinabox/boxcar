$(function() {
  if (location.pathname !== "/addons") { return; }

  var $addons = $('#addons');

  $.getJSON('/addons.json', {}, function(json, textStatus) {
    var html = '';

    $.each(json, function(index, addon) {
      html += ''+
        '<div class="addon" id="addon_' + addon.index + '">' +
          '<h2>' + addon.name + ' <small>' + addon.latest.number + '</small></h2>' +
          '<p class="lead">' + addon.latest.description + '</p>' +
        '</div>';
    });

    $addons.html(html);
  });

});
