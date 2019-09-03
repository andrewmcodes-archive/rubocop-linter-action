FROM ruby:2.6

LABEL com.github.actions.name="Rubocop Linter"
LABEL com.github.actions.description="Lint your Ruby code"
LABEL com.github.actions.icon="code"
LABEL com.github.actions.color="red"

LABEL maintainer="Andrew Mason <andrewmcodes@protonmail.com>"

COPY lib /action/lib
ENTRYPOINT ["/action/lib/entrypoint.sh"]
