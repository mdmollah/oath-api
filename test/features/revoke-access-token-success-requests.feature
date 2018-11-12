Feature:
      Revoke Access Token API Testing - Successfull Request

  Scenario: Grant Token
      Given I use the OAUTH target
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

    Scenario: :Revoke Access Token
        Given I use the OAUTH target
        And I set form parameters to
          | parameter          | value                       |
          | token              | `accesstoken`               |
        And I set headers to
          |name                    |value                                                                        |
          | Content-Type           | application/x-www-form-urlencoded                                           |
          | Authorization          | Basic eVZHaEtpVjV6MVpHZGFxRlhvWjhBaVNBOW41Q3JZNkI6cHl2SEVtR3JOcVJIQkhScA==  |
        When I POST to /revoke
        Then response code should be 200
