# bookstore-rails-api

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> JSON API app build using Ruby on Rails

> App generated using [this](https://github.com/rvvergara/rails-templates/tree/master/api_template) custom Rails Template

Version 1 Features:

- User account creation and update
- Token authentication using `devise` and `jwt`
- Request authorization using `pundit`
- Database search using `pg_search`
- Model and request specs using `rspec-rails` and `factory_bot_rails`

## Background

With frontend frameworks and libraries increasing the complexities of processes that happen on the client side, we can now build simpler backend applications. REST API's connect such client-side applications to the database.

I built this backend API mainly for the application I built using React and Redux (as well as a server-rendered version using Next JS).

## Table of Contents

- [bookstore-rails-api](#bookstore-rails-api)
  - [Table of Contents](#table-of-contents)
  - [Technologies used](#main-technologies-used)
  - [Install](#install)
  - [Usage](#usage)
  - [API](#api)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)
  - [License](#license)

## Main Technologies used

- Ruby on Rails
- PostgreSQL
- Devise
- JWT
- Pundit
- Jbuilder
- PG Search (for search capability)
- RSpec
- FactoryBot

## Install

Follow these steps:

- clone this repo
- `cd bookstore-rails-api`
- `bundle`

## Usage

```
rails s
```

Goto `localhost:3000`

Use either `httpie` on the terminal or Postman to do requests

See this [React Redux app](https://bookstore-cms-react-redux-app.herokuapp.com) as showcase for how the API is utilized.

## Maintainer

[Ryan](https://github.com/rvvergara)

## Contributing

[Ryan](https://github.com/rvvergara)

PRs accepted.

## License

MIT © 2019 Ryan Vergara
