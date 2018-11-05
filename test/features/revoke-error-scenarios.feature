Feature:
    Sample OAUTH API Testing

    Background:
      Given I use the OAUTH target

    Scenario: Error Request:Revoke - Invalid Token Type Hint
        And I set form parameters to
          | parameter     | value              |
          | token              | access_token  |
          | token_type_hint    | access        |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /revoke
        Then response code should be 400
        And response body should contain invalid_request
        And response body should contain OAuth revoke token grant request is malformed.

    Scenario: Error Request:Revoke - Invalid Client Secret
        And I set form parameters to
          | parameter     | value              |
          | token              | access_token  |
          | token_type_hint    | access_token        |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnN           |
        When I POST to /revoke
        Then response code should be 400
        And response body should contain invalid_client
        And response body should contain Client application cannot be authenticated.
