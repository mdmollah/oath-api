Feature:
    Refresh Token API Testing - Error Requests

    Background:
      Given I use the OAUTH target

    Scenario: Refresh - Invalid Token
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
        | refresh_token | invalid_token  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain invalid_grant
      And response body should contain Refresh token is invalid.

    Scenario: Refresh - Invalid Client Secret
      And I set form parameters to
        | parameter     | value                             |
        | grant_type    | refresh_token                     |
        | refresh_token | gPBuojafy43lKYwA8tPjrzqiGHgkgGwi  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JO              |
      When I POST to /token
      Then response code should be 401
      And response body should contain invalid_client
      And response body should contain Client credentials are invalid

    Scenario: Refresh - Missing Parameter
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain "errorCode":"400 Bad Request",
      And response body should contain  "error":"Invalid Request"
      And response body should contain OAuth Token refresh Request is malformed

    Scenario: Refresh - Unknown Parameter
      And I set form parameters to
        | parameter     | value                             |
        | grant_type    | refresh_token                     |
        | refresh_token | gPBuojafy43lKYwA8tPjrzqiGHgkgGwi  |
        | Unknown       | whatever                          |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain "errorCode":"400 Bad Request",
      And response body should contain  "error":"Invalid Request"
      And response body should contain OAuth Token refresh Request is malformed
