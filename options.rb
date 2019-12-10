require 'homebus_app_options'

class ESP32CamHomeBusAppOptions < HomeBusAppOptions
  def app_options(op)
    camera_still_help = 'URL that returns still image from ESP32Cam'

    op.separator 'ESP32Cam options:'
    op.on('-u', '--url CAMERA_STILL_URL', camera_still_help) { |value| options[:camera_still_url] = value }
  end

  def banner
    'HomeBus CTRL-H cameras'
  end

  def version
    '0.0.1'
  end

  def name
    'homebus-ctrlh-camera'
  end
end
