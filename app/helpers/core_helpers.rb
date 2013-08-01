# = Helpers =
helpers do
  # gives us asset_path helpers
  include Sprockets::Helpers

  # overrides Sinatra's defaults to allow calling like this:
  #   erb 'partials/flash'
  #
  # instead of
  #   erb 'partials/flash'.to_sym
  #
  # or
  #   erb :"partials/flash"
  #
  # which is just weird and ugly.
  #
  # also, defaults to not use a layout file when the request is made of XHR
  def erb(template, options = {}, locals = {})
    template = template.to_sym

    # figure out the layout
    if options[:layout].is_a?(FalseClass)
      # we're fine
    elsif options[:layout].present?
      options[:layout] = options[:layout].to_sym
    else
      options[:layout] = !request.xhr?
    end

    super
  end

  # Cookie getter / setter
  #
  # Setter (sets the 'my-cookie' cookie to 'this here is a value'):
  #
  #   cookie 'my-cookie', 'this here is a value'
  #
  # Getter
  #
  #   cookie 'my-cookie' # => 'this here is a value'
  #
  def cookie(name, value = nil, duration = 15)
    if value
      response.set_cookie name, {
        :value    => value,
        :expires  => Time.now + (60 * duration),
        :path     => "/",
        :httponly => true,
        :secure   => production?
      }
    else
      request.cookies[name]
    end
  end

  # checks the params hash for a single argument as both !nil and !empty
  def ensure_param(arg)
    params[arg.to_sym].present?
  end

  # checks an array of params from the params hash
  def ensure_params(*args)
    return catch(:truthy) {
      args.each do |arg|
        throw(:truthy, false) unless ensure_param(arg)
      end

      throw(:truthy, true)
    }
  end
end
