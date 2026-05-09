#!/bin/bash

# Passive Portfolio Flask App Startup Script

echo "Starting Passive Portfolio Flask App..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Warning: .env file not found. Please create one with the required API keys:"
    echo "PRICE_API_KEY=your_marketstack_api_key"
    echo "EXCHANGE_API_KEY=your_exchangerates_api_key"
    echo "FLASK_SECRET_KEY=your_secret_key"
    echo "APP_PASSWORD=your_app_password"
    echo ""
    echo "See README.md for more details."
fi

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install/update requirements
echo "Installing requirements..."
pip install -r requirements.txt

# Run the Flask app
echo "Starting Flask app on http://0.0.0.0:8080"
python3 flask_app.py