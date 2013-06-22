Feature: Rover control
  As a user of the library
  I want to be able to send instructions to the rovers
  So they can move on Mars

  Scenario: Controlling two rovers
    Given I can control the rovers
    When  I send the instructions:
    """
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    """
    Then the output should be:
    """
    1 3 N
    5 1 E

    """

  Scenario: Invalid instructions
    Given I can control the rovers
    When  I send the instructions:
    """
    5 A
    1 2 N
    LMLMLMLMM
    3 3 E
    LNR
    """
    Then the output should be:
    """
    invalid grid dimension (5 A)
    invalid rover movements (LNR)

    """