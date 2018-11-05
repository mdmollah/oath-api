Feature:
    Sample OAUTH API Testing

    Background:
      Given I use the OAUTH target

    Scenario: Validate Response Code:grant_token
        And I set body to {"grant_type": "password","username":"gooduser","password":"valid_password"}
        And I set headers to
          |name                    |value                                 |
          | Content-Type           | application/x-www-form-urlencoded    |
        When I POST to /token
        Then response code should be 200
