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

  Scenario: The rover can't exist the grid
    Given I can control the rovers
    When  I send the instructions:
    """
    5 5
    1 2 N
    LMMM
    3 3 E
    MMRMMRMRRM
    4 4 N
    MM
    """
    Then the output should be:
    """
    0 2 W (stopped to not exist the grid)
    5 1 E
    4 5 N (stopped to not exist the grid)
    """

    Scenario: Two rovers can't be on the same square
      Given I can control the rovers
      When  I send the instructions:
      """
      5 5
      1 2 N
      MRM
      2 2 N
      MMM
      """
      Then the output should be:
      """
      2 3 E
      2 2 N (stopped to avoid a collision)
      """