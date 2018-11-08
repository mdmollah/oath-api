Feature:
    Revoke Access Token API Testing - Error Requests

    Background:
      Given I use the OAUTH target

    Scenario: Revoke - Invalid Token Type Hint
        And I set form parameters to
          | parameter          | value              |
          | token              | access_token       |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /revoke
        Then response code should be 400
        And response body should contain invalid_token
        And response body should contain OAuth Token is not a valid token

    Scenario: Grant Token
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | demo-user       |
          | password    | demo-password   |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 200
        And I store the value of body path $.access_token as accesstoken in global scope

    Scenario: Revoke - Invalid Client Secret
        And I set form parameters to
          | parameter     | value              |
          | token         | `accesstoken`      |
        And I set headers to
          |name                    |value                                |
          | Content-Type           | application/x-www-form-urlencoded   |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjh   |
        When I POST to /revoke
        Then response code should be 400

    Scenario: Revoke - Unknown Parameter
        And I set form parameters to
          | parameter     | value              |
          | token              | access_token  |
          | token_type_hint    | access_token  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /revoke
        Then response code should be 400
        And response body should contain invalid_request
        And response body should contain OAuth Token Grant Request is malformed
