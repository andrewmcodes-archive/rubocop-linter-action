# Introduction

This GitHub Action provides a way to easily run Rubocop on your Ruby or Ruby on Rails project. While it is possible to write a custom GitHub Action to run Rubocop on your codebase, this action takes that functionality one step further using the Checks API. After the Rubocop Linter Action runs Rubocop against your Ruby code, it will create annotations that you can easily view in the GitHub UI, matched up with the offending code.

Since GitHub Actions and the Checks API are continually changing, it is possible that there will be breaking API changes that affect this action. If so, please open an issue and we will look into it as soon as we can. Thank you for using this project! :heart:
