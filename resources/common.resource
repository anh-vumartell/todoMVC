*** Settings ***
Library    SeleniumLibrary
Library    ../libs/Generators.py
Library    Collections

*** Variables ***
${BROWSER}    chrome
${URL}    https://todomvc.com/examples/react/#/
${DEFAULT_TIMEOUTS}    10s
${TODO_INPUT}    //input[@class="new-todo"]
${TODO_LIST}    //ul[@class="todo-list"]
${TODO_LIST_ITEM}     //ul[@class="todo-list"]//li
${TODO_COUNT}    //span[@class="todo-count"]

*** Keywords ***
Open Todo App
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Add A Todo
    [Arguments]    ${todo}
    Wait Until Element Is Visible    ${TODO_INPUT}    ${DEFAULT_TIMEOUTS}
    Input Text    ${TODO_INPUT}    ${todo}
    Press Keys    ${TODO_INPUT}    RETURN

Clear Local Storage
    Execute Javascript    window.localStorage.clear()

Clear Local Storage And Close Browser
    Clear Local Storage
    Close Browser

Add A Random Number Of Todos
    @{todos}=    Generate Random Todos
    Set Global Variable    ${todos}
    FOR    ${todo}    IN    @{todos}
        Add A Todo    ${todo}
    END

Add ${num_todos} Todos
    @{todos}=    Generate Todos    ${num_todos}
    FOR    ${todo}    IN    @{todos}
        Add A Todo    ${todo}
    END

Add Only One Todo
    [Arguments]    ${todo}
    Add A Todo    ${todo}

Check Todos List Length
    ${todo_list_length}=    Get Length    ${todos}
    Set Global Variable    ${todo_list_length}

Get A Todo From List
    [Arguments]    ${index}
    ${todo_title}=    Get From List    ${todos}    ${index}
    RETURN    ${todo_title}

Number Of List Items Should Be
    [Arguments]    ${number}
    ${list_items}=   Get Element Count    ${TODO_LIST_ITEM}
    Should Be True   ${list_items} == ${number}

Check A Random Todo From List And Checked Todo Is Removed
    IF    ${todo_list_length} == 1
        Check First Todo
        Page Should Not Contain    //ul[@class="todo-list"]//li[1]
        RETURN
    ELSE
        Check A Todo At A Random Index
        Page Should Not Contain    //ul[@class="todo-list"]//li[${index}]
    END

Check A Todo At A Random Index
    ${index}=   Evaluate    random.randint(1,${todo_list_length})    modules=random
    Set Test Variable    ${index}
    Select Checkbox    //ul[@class="todo-list"]//li[${index}]//input[@class="toggle"]

Check First Todo
    Select Checkbox     //ul[@class="todo-list"]//li[1]//input[@class="toggle"]

Check ${num_items} Todos
    ${x}=    Set Variable    1
    WHILE    ${x} <= ${num_items}
         Select Checkbox     //ul[@class="todo-list"]//li[${x}]//input[@class="toggle"]
         ${x}=    Evaluate    ${x} + 1
    END

Number Of List Item Should Decrease By One
    ${todos_left}    Evaluate    ${todo_list_length} - 1
    IF    ${todos_left} == 0
        Page Should Not Contain    ${TODO_COUNT}
    ELSE IF    ${todos_left} == 1
        Element Text Should Be    ${TODO_COUNT}    1 item left
    ELSE
        Element Text Should Be    ${TODO_COUNT}    ${todos_left} items left
    END

Number Of Items Left Should Be Total ${num_added_todos} Todos Decrease By ${num_checked_items}
    Set Test Variable    ${num_added_todos}
    Set Test Variable    ${num_checked_items}
    ${items_left}=    Set Variable    ${${num_added_todos} - ${num_checked_items}}
    Element Text Should Be    ${TODO_COUNT}    ${items_left} items left

Checked Todo Item At ${position}. Of List Is Removed
    Page Should Not Contain    //ul[@class="todo-list"]//li[${position}]
