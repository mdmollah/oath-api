Feature:
      Revoke Access Token API Testing - Successfull Request

    Scenario: :Revoke Access Token
        Given I use the OAUTH target
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
