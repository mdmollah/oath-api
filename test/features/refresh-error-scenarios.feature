Feature:
    Sample OAUTH API Testing

    Background:
      Given I use the OAUTH target

    Scenario: Error Request:Refresh - Invalid Token
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
        | refresh_token | invalid_token  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain invalid_grant
      And response body should contain Refresh token is invalid.

    Scenario: Error Request:Refresh - Invalid Client Secret
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
        | refresh_token | refresh_token  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMn            |
      When I POST to /token
      Then response code should be 400
      And response body should contain invalid_client
      And response body should contain Client application cannot be authenticated

    Scenario: Error Request:Refresh - Missing Parameter
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain invalid_request
      And response body should contain OAuth refresh token grant request is malformed.

    Scenario: Error Request:Refresh - Unknown Parameter
      And I set form parameters to
        | parameter     | value          |
        | grant_type    | refresh_token  |
        | refresh_token | refresh_token  |
        | Unknown       | whatever       |
      And I set headers to
        |name                    |value                                                                        |
        | Content-Type           | application/x-www-form-urlencoded                                           |
        | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
      When I POST to /token
      Then response code should be 400
      And response body should contain invalid_request
      And response body should contain OAuth refresh token grant request is malformed.
