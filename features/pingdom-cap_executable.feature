Feature: pingdom-cap executable

  In order to get my Pingdom checks the way I want
  As a developer familiar with the command line
  I want to be able to exercise Pingdom from the command line

  @slow_process
  Scenario: Status check
    When ERB I successfully run `pingdom-cap <%= ENV['PINGDOM_CHECK_NAME'] %> status`
    Then ERB the output should contain "Status for Pingdom '<%= ENV['PINGDOM_CHECK_NAME'] %>'"
    And ERB the output should contain:
    """
    "name" => "<%= ENV['PINGDOM_CHECK_NAME'] %>"
    """

  @slow_process
  Scenario: Pause check
    When ERB I successfully run `pingdom-cap <%= ENV['PINGDOM_CHECK_NAME'] %>  pause`
    Then ERB the output should contain "Pausing Pingdom '<%= ENV['PINGDOM_CHECK_NAME'] %>'"

  @slow_process
  Scenario: Unpause check
    When ERB I successfully run `pingdom-cap <%= ENV['PINGDOM_CHECK_NAME'] %> unpause`
    Then ERB the output should contain "Unpausing Pingdom '<%= ENV['PINGDOM_CHECK_NAME'] %>'"
