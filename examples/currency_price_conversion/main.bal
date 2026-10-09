import ballerina/io;
import ballerinax/cloudmersive.currency;

configurable string apiKey = ?;
configurable string sourceCurrency = "USD";
configurable string destinationCurrency = "EUR";
configurable decimal price = 19.99d;

// Validates the requested currencies against the supported list, then converts a price.
public function main() returns error? {
    currency:Client currencyClient = check new ({apikey: apiKey});

    currency:AvailableCurrencyResponse available = check currencyClient->listAvailableCurrencies();
    currency:AvailableCurrency[] currencies = available?.currencies ?: [];

    boolean sourceSupported = false;
    boolean destinationSupported = false;
    foreach currency:AvailableCurrency c in currencies {
        string? code = c?.iSOCurrencyCode;
        if code == sourceCurrency {
            sourceSupported = true;
        }
        if code == destinationCurrency {
            destinationSupported = true;
        }
    }
    if !sourceSupported || !destinationSupported {
        return error(string `Unsupported currency pair: ${sourceCurrency} -> ${destinationCurrency}`);
    }

    currency:ConvertedCurrencyResult result = check currencyClient->convertCurrency(sourceCurrency, destinationCurrency, price);
    io:println("Converted price: ", result?.formattedPriceAsString ?: "n/a");
}
