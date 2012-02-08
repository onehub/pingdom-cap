Feature: pingdom-cap executable

  In order to get my Pingdom checks the way I want
  As a developer familiar with the command line
  I want to be able to exercise Pingdom from the command line

  @slow_process
  Scenario: Status check
    When I successfully run `pingdom-cap training.icisapp.com status`
    Then the output should contain "Status for Pingdom 'training.icisapp.com'"
    And the output should contain:
    """
    "name" => "training.icisapp.com"
    """

  @slow_process
  Scenario: Pause check
    When I successfully run `pingdom-cap training.icisapp.com pause`
    Then the output should contain "Pausing Pingdom 'training.icisapp.com'"

  @slow_process
  Scenario: Unpause check
    When I successfully run `pingdom-cap training.icisapp.com unpause`
    Then the output should contain "Unpausing Pingdom 'training.icisapp.com'"
