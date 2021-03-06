Feature:
    Grant Token API Testing - Successfull Request

    Scenario: Grant Token
        Given I use the OAUTH target
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | demo-user        |
          | password    | demo-password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /token
        Then response code should be 200
        And response body should be valid json
        And response body path $.refresh_token_expires_in should not be null
        And response body path $.token_type should not be null
        And response body path $.access_token should not be null
        And response body path $.refresh_token should not be null
        And response body path $.expires_in should not be null
        And response body path $.refresh_count should not be null
        And response body path $.token_type should be BearerToken
        And response body path $.refresh_count should be 0
