// Generated by CoffeeScript 1.3.3

/*
  shortcode.js Services
  Collection of shortcode replacements
  by Nic Aitch @nicinabox
  MIT License
*/


(function() {

  $.fn.shortcode.services = {
    overview: function(options, node, that) {
      var $markup;
      options = $.extend({
        target: "h3",
        "class": "overview"
      }, options);
      $markup = $("<nav class='" + options["class"] + "'>");
      $(options.target, that.$el).each(function() {
        var id, text;
        text = $(this).text();
        id = text.toLowerCase().replace(/[^\s\w]/g, '').replace(/\s/g, '-');
        $(this).attr('id', id);
        return $markup.append("<a href='#" + id + "'>" + text + "</a>");
      });
      return $markup;
    }
  };

}).call(this);