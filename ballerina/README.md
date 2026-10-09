## Overview

The Cloudmersive Currency connector provides programmatic access to the [Cloudmersive Currency API](https://api.cloudmersive.com/docs/currency.asp), which helps you retrieve exchange rates and convert prices between currencies. This connector supports version 1 of the API and lets Ballerina applications look up supported currencies, fetch live exchange rates and convert prices with a few remote method calls.

### Key features

- List the currencies and countries supported by the API
- Retrieve the current exchange rate between any two supported currencies
- Convert a price from a source currency into a destination currency
- Authenticate with a single Cloudmersive API key

## Setup guide

To use this connector you need a Cloudmersive API key.

1. Sign up or log in at the [Cloudmersive portal](https://account.cloudmersive.com/).
2. Open the **API Keys** page of your account.
3. Create a new API key, or copy an existing one.
4. Supply the key as the `apikey` field when you initialize the client. Keep it out of source control, for example by reading it from `Config.toml`.

## Quickstart

1. Add the import:

    ```ballerina
    import ballerinax/cloudmersive.currency;
    ```

2. Create a `Config.toml` with your API key:

    ```toml
    apiKey = "<YOUR_API_KEY>"
    ```

3. Declare the configurable for the API key:

    ```ballerina
    configurable string apiKey = ?;
    ```

4. Create the client and invoke an operation:

    ```ballerina
    public function main() returns error? {
        currency:Client currencyClient = check new ({apikey: apiKey});
        currency:ExchangeRateResult _ = check currencyClient->getExchangeRate("USD", "EUR");
    }
    ```

## Examples

The `Cloudmersive Currency` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.currency/tree/main/examples/), covering the following use cases:

- [currency_price_conversion](../examples/currency_price_conversion/currency_price_conversion.md) - Validate a currency pair against the supported list and convert a price.
- [exchange_rate_lookup](../examples/exchange_rate_lookup/exchange_rate_lookup.md) - Look up exchange rates from a base currency to several targets.
