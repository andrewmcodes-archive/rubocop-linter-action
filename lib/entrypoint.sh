#!/bin/sh

set -e

gem install rubocop rubocop-performance rubocop-rails

ruby /action/lib/index.rb
