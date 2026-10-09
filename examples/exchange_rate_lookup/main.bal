import ballerina/io;
import ballerina/lang.regexp as re;
import ballerinax/cloudmersive.currency;

configurable string apiKey = ?;
configurable string baseCurrency = "USD";
configurable string targetCurrencies = "EUR,GBP,JPY";

// Looks up the exchange rate from a base currency to each target currency.
public function main() returns error? {
    currency:Client currencyClient = check new ({apikey: apiKey});

    foreach string entry in re:split(re `,`, targetCurrencies) {
        string target = entry.trim();
        currency:ExchangeRateResult rate = check currencyClient->getExchangeRate(baseCurrency, target);
        decimal? value = rate?.exchangeRate;
        if value is () {
            return error(string `No exchange rate returned for ${baseCurrency} -> ${target}`);
        }
        io:println(string `1 ${baseCurrency} = ${value} ${target}`);
    }
}
