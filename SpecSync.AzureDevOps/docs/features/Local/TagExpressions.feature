Feature: Tag expressions

Scenario Outline: Tag expression syntax
	Given Scenario "Green" has tags "<matching tags>"
	And Scenario "Red" has tags "<non-matching tags>"
	When the tag expression "<tag expression>" is evaluated for the scenarios
	Then Scenario "Green" should match
	And Scenario "Red" should not match
Examples: 
	| description          | tag expression            | matching tags        | non-matching tags |
	| contains tag         | @finished                 | @foo @finished @bar  | @foo @bar         |
	| empty does not match | @finished                 | @finished            |                   |
	| and                  | @finished and @automated  | @automated @finished | @finished         |
	| or                   | @finished or @automated   | @finished            |                   |
	| not                  | not @finished             | @foo                 | @finished         |
	| parenthesis          | not (@manual or @ignored) | @foo                 | @ignored          |
	| tail wildcard        | @bug:*                    | @bug:123             |                   |
