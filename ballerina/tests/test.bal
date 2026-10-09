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

import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.cloudmersive.com/currency/exchange-rates" : "http://localhost:9090";
final string apiKey = isLiveServer ? os:getEnv("CLOUDMERSIVE_API_KEY") : "test_api_key";

function initClient() returns Client|error {
    if isLiveServer && apiKey.trim() == "" {
        return error("CLOUDMERSIVE_API_KEY must be set when IS_LIVE_SERVER=true");
    }
    return new ({apikey: apiKey}, {}, serviceUrl);
}

final Client cloudmersiveClient = check initClient();

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListAvailableCurrencies() returns error? {
    AvailableCurrencyResponse response = check cloudmersiveClient->listAvailableCurrencies();
    AvailableCurrency[]? currencies = response?.currencies;
    test:assertTrue(currencies is AvailableCurrency[] && currencies.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testConvertCurrency() returns error? {
    ConvertedCurrencyResult response = check cloudmersiveClient->convertCurrency("USD", "EUR", 19.99);
    test:assertTrue(response?.convertedPrice !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetExchangeRate() returns error? {
    ExchangeRateResult response = check cloudmersiveClient->getExchangeRate("USD", "EUR");
    test:assertTrue(response?.exchangeRate !is ());
}
