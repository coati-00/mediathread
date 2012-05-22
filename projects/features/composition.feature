Feature: Composition
        
    Scenario: 1. Composition - create by test_instructor
        Using selenium
        Given I am test_instructor in Sample Course
        Given there are no projects
        
        # Create a project from the home page
        There is a New Composition button
        When I click the New Composition button
        Then I am at the Untitled page
        I see "by Instructor One"
        And I see "Private - Only Author(s) Can View"
        And I see "Version 1"
        
        # Verify user is able to edit the project
        There is an open Composition panel
        
        The Composition panel has a Revisions button
        And the Composition panel has a Preview button
        And the Composition panel has a Save button
        And the Composition panel has a +/- Author button
        
        # Add a title and some text
        Then I call the Composition "Composition: Scenario 1"
        And I write some text for the Composition
        
        # Save
        When I click the Save button
        Then I see a Save Changes dialog
        There is a project visibility "Private - Only Author(s) Can View"
        There is a project visibility "Publish Assignment to Whole Class"
        There is a project visibility "Publish to Whole Class"
        There is not a project visibility "Publish to World"
        And the project visibility is "Private - Only Author(s) Can View"
        
        When I save the changes
        Then I see "Version 2"
        
        # The project shows on Home
        When I click the HOME button
        Then I wait 2 seconds
        Then there is a private "Composition: Scenario 1" project by Instructor One
        
        # The project shows on Recent Activity
        When I click the Recent Activity button
        Then the most recent notification is "Composition: Scenario 1"
        
        Finished using Selenium

    Scenario: 2. Composition - create by test_student_one
        Using selenium
        Given I am test_student_one in Sample Course
        Given there are no projects
        
        # Create a project from the home page
        There is a New Composition button
        When I click the New Composition button
        Then I am at the Untitled page
        I see "by Student One"
        And I see "Private - Only Author(s) Can View"
        And I see "Version 1"
        
        # Verify user is able to edit the project
        There is an open Composition panel
        
        The Composition panel has a Revisions button
        And the Composition panel has a Preview button
        And the Composition panel has a Save button
        And the Composition panel has a +/- Author button
        
        # Add a title and some text
        Then I call the Composition "Composition: Scenario 2"
        And I write some text for the Composition
        
        # Save
        When I click the Save button
        Then I see a Save Changes dialog
        There is a project visibility "Private - Only Author(s) Can View"
        There is a project visibility "Submit to Instructor"
        There is a project visibility "Publish to Whole Class"
        There is not a project visibility "Publish to World"
        And the project visibility is "Private - Only Author(s) Can View"
        
        When I save the changes
        Then I see "Version 2"
        
        # The project shows on Home
        When I click the HOME button
        Then I wait 2 seconds
        Then there is a private "Composition: Scenario 2" project by Student One
        
        # The project shows on Recent Activity
        When I click the Recent Activity button
        Then the most recent notification is "Composition: Scenario 2"
        
        Finished using Selenium

    Scenario Outline: 3. Homepage Composition Visibility - Student Viewing Instructor Created Information / Assignments
        Using selenium
        Given I am test_instructor in Sample Course
                
        # Create a project from the home page
        There is a New Composition button
        When I click the New Composition button
        Then I am at the Untitled page
        Then I call the Composition "<title>"
        
        # Save
        When I click the Save button
        Then I see a Save Changes dialog
        Then I set the project visibility to "<visibility>"
        When I save the changes
        Then I see "Version 2"
        Then I see "<status>"
        
        # Try to view as student one
        Given I am test_student_one in Sample Course
        Then the instructor panel has <count> projects named "<title>"
        
        Finished using Selenium
             
      Examples:
        | title   | visibility                        | status                            | count |
        | private | Private - Only Author(s) Can View | Private - Only Author(s) Can View | 0     |
        | assign  | Publish Assignment to Whole Class | Assignment                        | 1     |
        | public  | Publish to Whole Class            | Published to Class                | 1     |
                 
    Scenario Outline: 4. Homepage Composition Visibility - Student/Instructor Viewing Another Student's Compositions
        Using selenium
        Given I am test_student_one in Sample Course
                
        # Create a project from the home page
        There is a New Composition button
        When I click the New Composition button
        Then I am at the Untitled page
        Then I call the Composition "<title>"
        
        # Save
        When I click the Save button
        Then I see a Save Changes dialog
        Then I set the project visibility to "<visibility>"
        When I save the changes
        Then I see "Version 2"
        Then I see "<status>"
        
        # Try to view as student two
        Given I am test_student_two in Sample Course
        When I select "Student One" as the owner in the Analysis column
        Then the owner is "Student One" in the Analysis column
        Then the classwork panel has <count> projects named "<title>"

        # Try to view as test_instructor
        Given I am test_instructor in Sample Course
        When I select "Student One" as the owner in the Analysis column
        Then the owner is "Student One" in the Analysis column
        Then the classwork panel has <count> projects named "<title>"
        
        Finished using Selenium
             
      Examples:
        | title   | visibility                        | status                            | count |
        | private | Private - Only Author(s) Can View | Private - Only Author(s) Can View | 0     |
        | public  | Publish to Whole Class            | Published to Class                | 1     |

            
        