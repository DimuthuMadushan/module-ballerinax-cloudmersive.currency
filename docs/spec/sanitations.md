_Author_:  @DimuthuMadushan \
_Created_: 2026/10/09 \
_Updated_: 2026/10/09 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Cloudmersive Currency. 
The OpenAPI specification is obtained from [`wso2/api-specs`](https://github.com/wso2/api-specs/blob/main/openapi/cloudmersive/currency/v1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Rename operations
- **Original**: `CurrencyExchange_GetAvailableCurrencies`, `CurrencyExchange_ConvertCurrency`, `CurrencyExchange_GetExchangeRate`.
- **Updated**: `listAvailableCurrencies`, `convertCurrency`, `getExchangeRate` (recorded in `ai-mappings.json`).
- **Reason**: Concise, intent-revealing method names without the tag prefix.

2. Change the API host from the test host to the production host (edit to `docs/spec/openapi.json`)
- **Original**: The Swagger 2.0 spec declares `host: testapi.cloudmersive.com`, a test host that is not a valid default endpoint.
- **Updated**: `host: api.cloudmersive.com` with `schemes: [https]`, so the client's default `serviceUrl` is `https://api.cloudmersive.com/currency/exchange-rates`.
- **Reason**: `api.cloudmersive.com` is the production host, the same one the other Cloudmersive connectors use.

3. Update the API Paths
- **Original**: Paths included common prefix `/currency/exchange-rates` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

4. Collapse the double slash in the server URL (hand edit to `docs/spec/aligned_ballerina_openapi.json`; re-apply after a re-align)
- **Original**: After the `/currency/exchange-rates` prefix is folded into the server, the aligned spec's server URL is `https://api.cloudmersive.com//currency/exchange-rates`.
- **Updated**: `https://api.cloudmersive.com/currency/exchange-rates`.
- **Reason**: The doubled slash is invalid in the generated default `serviceUrl`. The edit is on the aligned spec and must be re-applied after a re-align.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2026.
