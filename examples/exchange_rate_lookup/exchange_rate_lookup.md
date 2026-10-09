# Exchange rate lookup

Looks up the current exchange rate from a base currency to each of several target currencies and prints the results.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  baseCurrency = "USD"
  targetCurrencies = "EUR,GBP,JPY"
  ```

## Run the example

```bash
bal run
```
