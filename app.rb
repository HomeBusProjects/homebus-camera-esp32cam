require 'homebus'
require 'homebus_app'
require 'mqtt'
require 'json'
require 'dotenv'

require 'net/http'
require 'base64'
require 'timeout'

class ESP32CamHomeBusApp < HomeBusApp
  DDC = 'org.homebus.image'

  def initialize(options)
    @options = options

    Dotenv.load('.env')
    @url = @options['camera-url'] || ENV['CAMERA_URL']
    @resolution = @options['camera-resolution'] || ENV['CAMERA_RESOLUTION']

    super
  end


  def setup!
  end

  def _set_resolution
    return true unless @resolution

    begin
      response = Timeout::timeout(30) do
        uri = URI("#{@url}/control?var=framesize&val=#{@resolution}")
        response = Net::HTTP.get_response(uri)
      end

      if response.code == "200"
        return true
      else
        return false
      end
    rescue
      puts "timeout"
      return false
    end
  end

  def _get_image
    begin
      response = Timeout::timeout(30) do
        uri = URI(@url + '/capture')
        response = Net::HTTP.get_response(uri)
      end

      if response.code == "200"
        return {
          mime_type: 'image/jpeg',
          data: Base64.encode64(response.body)
        }
      else
        nil
      end
    rescue
      puts "timeout"
      nil
    end
  end

  def work!
    if !@resolution || _set_resolution
      if @resolution
        sleep(5)
      end

      image = _get_image

      if image
        obj = {
          id: @uuid,
          timestamp: Time.now.to_i,
        }

        obj[DDC] = image

        publish! DDC, obj
      else
        puts "no image"
      end
    end

    sleep 60
 end

  def manufacturer
    'HomeBus'
  end

  def model
    ''
  end

  def friendly_name
    'ESP32Cam'
  end

  def friendly_location
    ''
  end

  def serial_number
    @url
  end

  def pin
    ''
  end

  def devices
    [
      { friendly_name: 'ESP32CAM',
        friendly_location: 'PDX Hackerspace',
        update_frequency: 60,
        index: 0,
        accuracy: 0,
        precision: 0,
        wo_topics: [ DDC ],
        ro_topics: [],
        rw_topics: []
      }
    ]
  end
end
