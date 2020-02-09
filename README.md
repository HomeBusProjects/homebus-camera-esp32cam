# HomeBus ESP32Cam Publisher

This is a simple Ruby program which reads a still image from an ESP32Cam and publishes it to Homebus.

## Configuration

The `.env` file contains the following parameters:

- `CAMERA_URL` - the http: URL for the ESP32Cam, may include port number
- `CAMERA_RESOLUTION` - forces the resolution of the still image; if not set will use whatever the camera is currently set to

Camera resolutions:
- 10 - 1600x1200
- 9 - 1280x1024
- 8 - 1024x768
