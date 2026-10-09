# Currency price conversion

Lists the currencies supported by the Cloudmersive Currency API, checks that the requested source and destination currencies are supported, and then converts a price between them.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  sourceCurrency = "USD"
  destinationCurrency = "EUR"
  price = 19.99
  ```

## Run the example

```bash
bal run
```
