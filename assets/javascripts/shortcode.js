var Shortcode, plugin = 'shortcode';

Shortcode = function(el, services) {
  this.services = $.extend($.fn.shortcode.services, services);
  this.$el = $(el);

  return this.init();
};

Shortcode.prototype = {
  node_class: "shortcode-node",

  init: function() {
    this.nodes = this.convertEachToNode();
    this.replaceNodes();
    return this;
  },

  matchService: function(service_name) {
    return new RegExp("\\[" + service_name + "(.*?)?\\]", "g");
  },

  parseServiceOptions: function(captures) {
    if (typeof captures === "string") {
      var crude_options   = captures.replace(/\"/g, '').split(' '),
          service_options = {};

      $.each(crude_options, function(i, val) {
        if (val) {
          var values = val.split('=');
          service_options[values[0]] = values[1];
        }
      });

      return service_options;
    }
  },

  convertEachToNode: function() {
    var that = this,
        nodes = {};

    $.each(this.services, function(service_name, val) {
      var regex = that.matchService(service_name),
          options = '',
          contains_match = '';

      that.$el.html(function(i, oldHTML) {
        return oldHTML.replace(regex, function(match, captures) {
          contains_match = match;
          options = captures;
          return "<span class='" + that.node_class + "'>" + match + "</span>";
        });
      });

      if (contains_match) {
        nodes[service_name] = that.$el.find(':contains(' + contains_match + ')').last();
        nodes[service_name].options = that.parseServiceOptions(options);
      }
    });

    return nodes;
  },

  replaceNodes: function() {
    var that = this,
        replacement = '';

    $.each(this.nodes, function(service_name, $node) {
      if (typeof that.services[service_name] === 'function') {
        replacement = that.services[service_name](
            that.nodes[service_name].options,
            $node,
            that
        );
      }

      if (replacement && $node.length) {
        that.$el.find($node).replaceWith(replacement);
      }
    });
  }
};

// jQuery plugin definition
$.fn[plugin] = function(services) {
  this.each(function() {
    if (!$.data(this, plugin)) {
      return $.data(this, plugin, new Shortcode(this, services));
    }
  });
};
