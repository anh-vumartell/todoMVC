*** Settings ***
Resource    ../resources/common.resource
Test Setup    Open Todo App
Test Teardown    Clear Local Storage And Close Browser
Library    Dialogs

*** Test Cases ***
Add Todos And Verify Number Of Todo Items
    [Documentation]    Check if ToDos can be added and number of todos increase
    [Tags]    add_todo
    Add A Random Number Of Todos
    Check Todos List Length
    Number Of List Items Should Be    ${todo_list_length}

Add Todos, Check Only One And Verify Number Of Todos Left
    [Tags]    check_todo
    Add A Random Number Of Todos
    Check Todos List Length
    Check First Todo
    Number Of List Item Should Decrease By One

Add Todos, Check Items And Verify Number Of Todos Left
    [Tags]    check_todo
    Add 5 Todos
    Check 2 Todos
    Number Of Items Left Should Be Total 5 Todos Decrease By 2

Add Todos, A Checked Todo Is Removed
    [Tags]    check_todo
    Add A Random Number Of Todos
    Check A Random Todo From List And Checked Todo Is Removed
