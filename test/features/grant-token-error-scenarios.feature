Feature:
    Grant Token API Testing - Error Requests

    Background:
      Given I use the OAUTH target

    Scenario: Grant - Invalid Password
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | gooduser        |
          | password    | invalid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain invalid_grant
        And response body should contain Subject requesting access cannot be authenticated.

    Scenario: Grant - Invalid Client Secret
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | gooduser        |
          | password    | valid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnN           |
        When I POST to /token
        Then response code should be 400
        And response body should contain invalid_client
        And response body should contain Client application cannot be authenticated

    Scenario: Grant - Invalid Grant Type
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | implicit        |
          | username    | gooduser        |
          | password    | valid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain unsuupported_grant_typet
        And response body should contain Only password grant type honored here.

    Scenario: Grant - Missing Parameter
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | password    | valid_password  |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain invalid_request
        And response body should contain OAuth token grant request is malformed.

    Scenario: Grant - Unknown Parameter
        And I set form parameters to
          | parameter   | value           |
          | grant_type  | password        |
          | username    | gooduser        |
          | password    | valid_password  |
          | Unknown     | whatever        |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic bFd1VklqbnFPZ1gzWmJHMk95alhRTHExWHptbTJDalk6WUFWQzJmbUwyMnNIM1RTeQ==  |
        When I POST to /token
        Then response code should be 400
        And response body should contain invalid_request
        And response body should contain OAuth token grant request is malformed.
