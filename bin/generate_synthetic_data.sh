#!/bin/bash

# Lightweight Synthetic Data Generator for Adafruit IO
# Uses BSD jot utility for random number generation

set -e

# Check required environment variables
if [ -z "$IO_USERNAME" ]; then
    echo "Error: IO_USERNAME environment variable is required"
    exit 1
fi

if [ -z "$IO_KEY" ]; then
    echo "Error: IO_KEY environment variable is required"
    exit 1
fi

# Configuration
FEED_NAME="demo-iot-data"
INTERVAL=10  # seconds between data points
BASE_URL="https://io.adafruit.com/api/v2"

# Initialize starting value
CURRENT_VALUE=50

echo "Starting lightweight synthetic data generation for feed: $FEED_NAME"
echo "Data points will be added every $INTERVAL seconds"
echo "Press Ctrl+C to stop"
echo ""

# Function to generate random change between -10 and +10
generate_change() {
    # Use jot to generate random integer between -10 and 10
    jot -r 1 -10 10
}

# Function to send data to Adafruit IO
send_data() {
    local value=$1
    local timestamp
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    echo "Sending value: $value at $timestamp"
    
    curl -s -X POST \
        -H "X-AIO-Key: $IO_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"value\": \"$value\"}" \
        "$BASE_URL/$IO_USERNAME/feeds/$FEED_NAME/data" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "✓ Successfully sent data point: $value"
    else
        echo "✗ Failed to send data point: $value"
    fi
}

# Trap Ctrl+C to gracefully exit
trap 'echo -e "\n\nStopping data generation..."; exit 0' INT

# Main loop
counter=1
while true; do
    # Generate change and update current value
    change=$(generate_change)
    CURRENT_VALUE=$((CURRENT_VALUE + change))
    
    echo "[$counter] Change: $change -> New value: $CURRENT_VALUE"
    
    # Send data to Adafruit IO
    send_data "$CURRENT_VALUE"
    
    # Increment counter and wait
    counter=$((counter + 1))
    echo "Waiting $INTERVAL seconds..."
    echo ""
    sleep $INTERVAL
done
