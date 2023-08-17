*** Settings ***
Resource    ../resources/common.resource
Suite Setup    Open Todo App
Suite Teardown    Clear Local Storage And Close Browser
Library    Dialogs

*** Test Cases ***
Add Random Number Of Todos And Verify Number Of Todo Items
    [Documentation]    Check if ToDos can be added and number of todos increase
    [Tags]    add_todo
    Add A Random Number Of Todos
    Get Todos List Length
    Number Of List Items Should Be    ${todo_list_length}

Add Random Number Of Todos, Check Only One And Verify Number Of Todos Left
    [Tags]    mark_todo
    Add A Random Number Of Todos
    Get Todos List Length
    Check One Todo At A Random Index
    Number Of List Item Should Decrease By One

