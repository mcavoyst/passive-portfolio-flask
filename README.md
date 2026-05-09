# Passive Portfolio Rebalancer

A tool to help you maintain your desired asset allocation in a passive stock portfolio. Given your current holdings and a target allocation, it calculates what to buy to rebalance — without selling.

Available as both a **web app** (Flask) and a **command-line tool**.

## Features

- **Dashboard**: View your full portfolio at a glance — holdings, values, and last update dates
- **Core / Satellite Split**: Rebalancing is calculated only on your "core" passive holdings; the "satellite" portfolio is tracked but not touched
- **No-Sell Rebalancing**: Calculates what to buy to hit your target allocation without selling existing positions
- **Investment Scenario**: Given a cash amount, shows exactly what to buy and in what order to best maintain your allocation
- **Live Prices**: Fetches current closing prices via the MarketStack API
- **Exchange Rate**: Converts USD holdings to CAD using the ExchangeRates API (with fallback to a local backup)
- **Add New Tickers**: Add new stocks to your portfolio directly from the web interface
- **Password Protected**: Simple session-based authentication for the web app

## Installation

1. **Clone the repository**
    ```bash
    git clone https://github.com/mcavoyst/passive-portfolio-flask.git
    cd passive-portfolio-flask
    ```

2. **Create and activate a virtual environment**
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```

3. **Install dependencies**
    ```bash
    pip install -r requirements.txt
    ```

4. **API keys**

    Two API keys are required:
    - [MarketStack](http://api.marketstack.com) — current stock prices
    - [ExchangeRates API](http://api.exchangeratesapi.io) — CAD/USD exchange rate

    Create a `.env` file in the root directory:
    ```
    PRICE_API_KEY=your_marketstack_key
    EXCHANGE_API_KEY=your_exchangerates_key
    FLASK_SECRET_KEY=some_long_random_string
    APP_PASSWORD=your_chosen_password
    ```

5. **Add your data**

    Place the following files in the `/data` folder (see `/example` for formatting):
    - `portfolio_data.csv` — your current holdings (ticker, exchange, quantity, currency, closing_price, update_date)
    - `model_portfolio.csv` — your target allocations by ticker (must sum to 1.00)
    - `exchange_rate.txt` — fallback exchange rate used if the API is unavailable

## Usage

### Web App (recommended)

```bash
./run.sh
```

Then open [http://localhost:8080](http://localhost:8080) and log in with your `APP_PASSWORD`.

From the dashboard you can:
- **Fetch Latest Prices** — updates all closing prices from the API and saves to CSV
- **Update Quantity** — set the current number of shares held for any ticker
- **Add New Ticker** — add a stock with auto-fetched or manually entered price
- **Investment Scenario** — enter a cash amount to see what to buy to best maintain your allocation
- **Rebalancing Report** — always visible; shows shares to buy and total cost to rebalance

### Command Line

```bash
python3 app/main.py
```

Follow the prompts to update prices, adjust quantities, view the rebalancing report, and run an investment scenario.

## Data Format

**`portfolio_data.csv`**
```
ticker,exchange,quantity,currency,closing_price,update_date
VFV,XTSE,385,CAD,179.42,2026-05-08 00:00:00+00:00
PLTR,XNYS,10,USD,137.80,2026-05-08 00:00:00+00:00
```

**`model_portfolio.csv`**
```
ticker,target_allocation
VFV,0.525
XIU,0.15
```
Allocations must sum to exactly 1.00.

## Supported Exchanges

| Code | Exchange | Currency |
|------|----------|----------|
| XTSE | Toronto Stock Exchange | CAD |
| XNYS | New York Stock Exchange | USD |
| ARCX | NYSE Arca | USD |
| XNAS | NASDAQ | USD |

## License

MIT
