*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${URL}    https://todomvc.com/examples/react/#/
${DEFAULT_TIMEOUTS}    10s
${TODO_INPUT}    //input[@class="new-todo"]
${TODO_LIST}    //ul[@class="todo-list"]
${TODO_LIST_ITEM}     //ul[@class="todo-list"]//li

*** Keywords ***
Open Todo App
    Open Browser    ${URL}    ${BROWSER}

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

Number Of List Items Should Be
    [Arguments]    ${number}
    ${list_items}=   Get Element Count    ${TODO_LIST_ITEM}
    Should Be True   ${list_items} == ${number}

   