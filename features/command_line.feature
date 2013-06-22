Feature: Command line
  As a rover controll user
  I want to be able to launch the instruction from the command line
  so I can easily run use the program

  Scenario: launch the instruction from a file
    Given a file named "inst" with:
    """
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    """
    When I run `rover_console inst`
    Then the exit status should be 0
    And  the output should contain:
    """
    1 3 N
    5 1 E
    """

  Scenario: launch with no file name
    When I run `rover_console`
    Then the exit status should be 1
    And  the stderr should contain:
    """
    usage rover_console FILE
    """

  Scenario: launch with non existing file
    When I run `rover_console not_exiting`
    Then the exit status should be 2
    And  the stderr should contain:
    """
    can not read file not_exiting
    """