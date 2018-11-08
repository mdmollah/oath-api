Feature:
    Grant Token API Testing - Error Requests

    Background:
      Given I use the OAUTH target

    Scenario: Grant - Invalid Password
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | demo-user        |
          | password    | invalid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain Invalid Grant
        And response body should contain User Requesting Access Cannot be Authenticated

    Scenario: Grant - Invalid Client Secret
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | demo-user        |
          | password    | demo-password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl                       |
        When I POST to /token
        Then response code should be 401
        And response body should contain invalid_client
        And response body should contain Client credentials are invalid

    Scenario: Grant - Invalid Grant Type
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | implicit        |
          | username    | demo-user        |
          | password    | demo-password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain unsupported_grant_type
        And response body should contain Only Password and Refresh token grant types honoured here.

    Scenario: Grant - Missing Parameter
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | password    | demo-password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain "errorCode":"400 Bad Request",
        And response body should contain  "error":"Invalid Request"
        And response body should contain OAuth Token Grant Request is malformed

    Scenario: Grant - Unknown Parameter
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | demo-user        |
          | password    | demo-password  |
          | Unknown     | whatever        |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain "errorCode":"400 Bad Request",
        And response body should contain  "error":"Invalid Request"
        And response body should contain OAuth Token Grant Request is malformed
