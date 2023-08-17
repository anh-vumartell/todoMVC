*** Settings ***
Resource    ../resources/common.resource
Suite Setup    Open Todo App
Suite Teardown    Clear Local Storage And Close Browser
Library    Dialogs

*** Test Cases ***
Add Two Todos And Check Number Of Items
    [Documentation]    Check if ToDos can be added and number of todos increase
    [Tags]    add_todo
    @{todos}=    Generate Todos
    FOR    ${todo}    IN    @{todos}
        Add A Todo    ${todo}
    END
    ${todo_list_length}=    Get Length    ${todos}
    Number Of List Items Should Be    ${todo_list_length}

