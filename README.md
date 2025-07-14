# Adafruit IO for TRMNL

[![Build and Deploy](https://github.com/stephenyeargin/trmnl-adafruit-io/actions/workflows/build.yml/badge.svg)](https://github.com/stephenyeargin/trmnl-adafruit-io/actions/workflows/build.yml)

![promo](assets/promo.png)

## Screenshots

![screenshot](assets/screenshot.png)

## Development

### Creating synthetic data

- Create an Adafruit IO project with the slug `demo-iot-data`
- Set the environment variables for `IO_USERNAME` and `IO_KEY`
- Run `./bin/generate_synthetic_data.sh` to generate a data point every 10 seconds
