class Main
  module ArrayHelpers
    def array_start_button
      <<-CODE
        <a  href="/array/start"
            id="start-array"
            class="btn btn-success navbar-btn #{"hide" if Boxcar::Array.started?}"
            data-loading-text="Starting...">
          <i class="icon-cloud"></i> Start Array
        </a>
      CODE
    end

    def array_stop_button
      <<-CODE
        <a  href="/array/stop"
            id="stop-array"
            class="btn btn-danger navbar-btn #{"hide" unless Boxcar::Array.started?}"
            data-loading-text="Stopping...">
          <i class="icon-exclamation-sign"></i> Stop Array
        </a>
      CODE
    end
  end

  helpers ArrayHelpers
end
