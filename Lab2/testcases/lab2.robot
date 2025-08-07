*** Settings ***

Library    SeleniumLibrary

Resource    ../ressources/lab2.robot

Suite Setup    Open web browser
Suite Teardown    Close web browser

*** Test Cases ***
Home Page Should Load
    [Documentation]    Test Case 1001: Home page should load (Smoke, Feature: Home)
    [Tags]    Smoke    Home
    Navigate To Home Page
    User Examines Home Page Contents

Login Should Succeed With Valid Credentials
    [Documentation]    Test Case 1002: Login should succeed with valid credentials (Smoke, Feature: Login)
    [Tags]    Smoke    Login
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Submit Button

Login Should Fail With Missing Credentials
    [Documentation]    Test Case 1003: Login should fail with missing credentials (Functional, Feature: Login)
    [Tags]    Functional    Login
    Navigate To Home Page
    Click Login Link
    Skip Login Credentials
    Click Submit Button Without Credentials

Remember Me Checkbox Should Persist Email Address
    [Documentation]    Test Case 1004: "Remember me" checkbox should persist email address (Functional, Feature: Login)
    [Tags]    Functional    Login
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Remember Me Checkbox
    Click Submit Button
    Click Logout Link
    Click Login Link
    # email n'eest pas pré-rempli car le champ est vide
    Verify Email Is Pre-populated

Should Be Able To Log Out
    [Documentation]    Test Case 1005: Should be able to log out (Functional, Feature: Login)
    [Tags]    Functional    Login
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Submit Button
    Click Logout Link

Customers Page Should Display Multiple Customers
    [Documentation]    Test Case 1006: Customers page should display multiple customers (Smoke, Feature: Customers)
    [Tags]    Smoke    Customers
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Submit Button
    Examine Customers Grid For Multiple Records

Should Be Able To Add New Customer
    [Documentation]    Test Case 1007: Should be able to add new customer (Smoke, Feature: Customers)
    [Tags]    Smoke    Customers
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Submit Button
    Click New Customer Button
    Type Customer Email
    Type Customer First Name
    Type Customer Last Name
    Type Customer City
    Select Customer State
    Select Gender
    Optionally Check Promotion Checkbox
    Click Customer Submit Button

Should Be Able To Cancel Adding New Customer
    [Documentation]    Test Case 1008: Should be able to cancel adding new customer (Functional, Feature: Customers)
    [Tags]    Functional    Customers
    Navigate To Home Page
    Click Login Link
    Type Valid Login Credentials
    Click Submit Button
    Click New Customer Button
    Click Cancel Button
