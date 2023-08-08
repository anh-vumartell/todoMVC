*** Settings ***
Resource    ../resources/common.resource
Suite Setup    Open Todo App
Suite Teardown    Clear Local Storage And Close Browser
Library    Dialogs

*** Test Cases ***
Add Two Todos And Check Number Of Items
    [Documentation]    Check if ToDos can be added and number of todos increase
    [Tags]    add_todo
    Add A Todo    Learning Robot Framework
    Add A Todo    Writing first test case
    Number Of List Item Should Be    2

