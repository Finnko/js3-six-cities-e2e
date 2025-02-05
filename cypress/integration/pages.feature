Feature: 1.1 Страницы приложения

  Background: Мокаю запросы к серверу
    Given подменяю данные о предложениях
    Given подменяю данные об обычном тестовом предложении
    Given подменяю запрос на логаут

  Scenario: Приложение состоит из нескольких страниц (публичные страницы, пользователь неавторизован)
    # Мокаю запросы к серверу
    Given пользователь неавторизован

    # Проверяю Main
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    Then элемент '.page--main' видим
    Then элемент '.page__main--index' видим
    Then элемента '.page--login' нет на странице
    Then элемента '.page__main--login' нет на странице
    Then элемента '.page__main--favorites' нет на странице
    Then элемента '.page__main--offer' нет на странице

    # Проверяю Offer
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён
    Then элемент '.page__main--offer' видим
    Then элемента '.page--main' нет на странице
    Then элемента '.page__main--index' нет на странице
    Then элемента '.page--login' нет на странице
    Then элемента '.page__main--login' нет на странице
    Then элемента '.page__main--favorites' нет на странице


  Scenario: Приложение состоит из нескольких страниц (приватные страницы, пользователь неавторизован)
    # Мокаю запросы к серверу
    Given пользователь неавторизован
    Given запрос на получение данных об избранных предложениях не должен отправляться

    # Проверяю Login
    When нахожусь на странице Login
    When запрос на получение данных об авторизации завершён
    Then элемент '.page--login' видим
    Then элемент '.page__main--login' видим
    Then элемента '.page--main' нет на странице
    Then элемента '.page__main--index' нет на странице
    Then элемента '.page__main--favorites' нет на странице
    Then элемента '.page__main--offer' нет на странице

    # Проверяю Favorites
    When нахожусь на странице Favorites
    When запрос на получение данных об авторизации завершён
    Then элемент '.page--login' видим
    Then элемент '.page__main--login' видим
    Then элемента '.page--main' нет на странице
    Then элемента '.page__main--index' нет на странице
    Then элемента '.page__main--favorites' нет на странице
    Then элемента '.page__main--offer' нет на странице


  Scenario: Приложение состоит из нескольких страниц (приватные страницы, пользователь авторизован)
    # Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях

    # Проверяю Login
    When нахожусь на странице Login
    When запрос на получение данных об авторизации завершён
    Then элемент '.page--main' видим
    Then элемент '.page__main--index' видим
    Then элемента '.page--login' нет на странице
    Then элемента '.page__main--login' нет на странице
    Then элемента '.page__main--favorites' нет на странице
    Then элемента '.page__main--offer' нет на странице

    # Проверяю Favorites
    When нахожусь на странице Favorites
    When запрос на получение данных об авторизации завершён
    When запрос на получение данных об избранных предложениях завершён
    Then элемент '.page__main--favorites' видим
    Then элемента '.page--main' нет на странице
    Then элемента '.page__main--index' нет на странице
    Then элемента '.page--login' нет на странице
    Then элемента '.page__main--login' нет на странице
    Then элемента '.page__main--offer' нет на странице


  Scenario: В шапке каждой страницы отображается ссылка на страницу «Login»
    # Мокаю запросы к серверу
    Given пользователь неавторизован

    # Проверяю наличие ссылки на Login
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    Then элемент '.header__nav-link--profile' содержит текст 'Sign in'
    When кликаю на элемент '.header__nav-link--profile'
    Then элемент '.page--login' видим
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён
    Then элемент '.header__nav-link--profile' содержит текст 'Sign in'
    When кликаю на элемент '.header__nav-link--profile'
    Then элемент '.page--login' видим

  Scenario: В шапке каждой страницы отображается email пользователя и кнопка «Log Out»
    # Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях

    # Проверяю наличие email пользователя и переадресацию на Favorites
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    Then элемент '.header__user-name' содержит текст 'test-user@htmlacademy.ru'
    Then элемент '.header__signout' содержит текст 'Sign out'
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён
    Then элемент '.header__user-name' содержит текст 'test-user@htmlacademy.ru'
    Then элемент '.header__signout' содержит текст 'Sign out'
    When нахожусь на странице Favorites
    When запрос на получение данных об избранных предложениях завершён
    Then элемент '.header__user-name' содержит текст 'test-user@htmlacademy.ru'
    Then элемент '.header__signout' содержит текст 'Sign out'

  Scenario: Клик по email пользователя в шапке выполняет переход на страницу «Favorites»
    # Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях

  # Проверяю переадресацию на Favorites
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    When кликаю на элемент '.header__user-name'
    Then элемент '.page__main--favorites' видим
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён
    When кликаю на элемент '.header__user-name'
    Then элемент '.page__main--favorites' видим
    When нахожусь на странице Favorites
    When запрос на получение данных об избранных предложениях завершён
    When кликаю на элемент '.header__user-name'
    Then элемент '.page__main--favorites' видим

  Scenario: Клик по кнопке «Log Out» приводит к выходу из закрытой части приложения
    # Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях

    # Проверяю логаут на Main
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    When кликаю на элемент '.header__signout'
    Then элемент '.header__nav-link--profile' содержит текст 'Sign in'
    Then элемента '.header__user-name' нет на странице
    Then элемента '.header__signout' нет на странице

    # Проверяю логаут на Favorites
    When нахожусь на странице Favorites
    When запрос на получение данных об избранных предложениях завершён
    When кликаю на элемент '.header__signout'
    Then элемент '.page--login' видим


  Scenario: Пользователь перенаправляется на страницу «404»
    Given пользователь неавторизован
    When нахожусь на несуществующей странице
    Then элемент '[href="/"]' видим
