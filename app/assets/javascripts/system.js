$(document).on('click', '#power-controls .dropdown-menu a', function(e) {
  e.preventDefault();
  $.post($(this).attr('href'), {}, function(data, textStatus, xhr) {
    console.log(data);
  });
});
