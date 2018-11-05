Feature:
    Sample OAUTH API Testing

    Background:
      Given I use the OAUTH target

    Scenario: Success Request:grant_token
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | gooduser        |
          | password    | valid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
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

    Scenario: Success Request:Refresh token
        And I set form parameters to
          | parameter     | value           |
          | grant_type    | refresh_token   |
          | refresh_token | refresh_token_replace        |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
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
        
    Scenario: Success Request:Revoke token
        And I set form parameters to
          | parameter     | value           |
          | token              | access_token   |
          | token_type_hint    | access_token    |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /revoke
        Then response code should be 200

    Scenario: Success Request:Revoke Refresh token
        And I set form parameters to
          | parameter     | value           |
          | token              | refresh_token   |
          | token_type_hint    | refresh_token    |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /revoke
        Then response code should be 200

    Scenario: Success Request:Refresh unknow access token
        And I set form parameters to
          | parameter          | value           |
          | token              | invalid_token   |
          | token_type_hint    | access_token    |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /revoke
        Then response code should be 200
