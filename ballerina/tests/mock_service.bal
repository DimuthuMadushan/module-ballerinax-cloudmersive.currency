// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

function isValidKey(string? apikey) returns boolean => apikey == "test_api_key";

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Converts a price from the source currency into the destination currency
    #
    # + 'source - Source currency three-digit code (ISO 4217), e.g. USD, EUR, etc
    # + destination - Destination currency three-digit code (ISO 4217), e.g. USD, EUR, etc
    # + payload - Input price, such as 19.99 in source currency
    # + apikey - Cloudmersive API key
    # + return - OK, or 401 when the API key is missing or invalid
    resource function post convert/[string 'source]/to/[string destination](@http:Payload decimal payload, @http:Header {name: "Apikey"} string? apikey) returns ConvertedCurrencyResult|http:Unauthorized {
        if !isValidKey(apikey) {
            return http:UNAUTHORIZED;
        }
        return {
            formattedPriceAsString: "EUR 18.35",
            iSOCurrencyCode: "EUR",
            convertedPrice: 18.35,
            currencySymbol: "€"
        };
    }

    # Gets the exchange rate from the source currency into the destination currency
    #
    # + 'source - Source currency three-digit code (ISO 4217), e.g. USD, EUR, etc
    # + destination - Destination currency three-digit code (ISO 4217), e.g. USD, EUR, etc
    # + apikey - Cloudmersive API key
    # + return - OK, or 401 when the API key is missing or invalid
    resource function post get/[string 'source]/to/[string destination](@http:Header {name: "Apikey"} string? apikey) returns ExchangeRateResult|http:Unauthorized {
        if !isValidKey(apikey) {
            return http:UNAUTHORIZED;
        }
        return {exchangeRate: 0.9183};
    }

    # Get a list of available currencies and corresponding countries
    #
    # + apikey - Cloudmersive API key
    # + return - OK, or 401 when the API key is missing or invalid
    resource function post list\-available(@http:Header {name: "Apikey"} string? apikey) returns AvailableCurrencyResponse|http:Unauthorized {
        if !isValidKey(apikey) {
            return http:UNAUTHORIZED;
        }
        return {
            currencies: [
                {
                    countryThreeLetterCode: "USA",
                    iSOCurrencyCode: "USD",
                    countryName: "United States",
                    currencyEnglishName: "United States dollar",
                    currencySymbol: "$",
                    isEuropeanUnionMember: false,
                    countryISOTwoLetterCode: "US"
                },
                {
                    countryThreeLetterCode: "DEU",
                    iSOCurrencyCode: "EUR",
                    countryName: "Germany",
                    currencyEnglishName: "Euro",
                    currencySymbol: "€",
                    isEuropeanUnionMember: true,
                    countryISOTwoLetterCode: "DE"
                }
            ]
        };
    }
}
