#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

dart run sort_members
dart format packages
dart analyze

for package in foxy foxy_widget; do
  (cd "packages/$package" && flutter test --dart-define=FOXY_LOG_STACK_TRACES=false)
done

for package in foxy_agent foxy_game_definition foxy_game_file; do
  (cd "packages/$package" && dart test)
done

# The generator and lint suites share an SDK cache and run serially in CI.
for package in foxy_generator foxy_lint; do
  (cd "packages/$package" && dart test -j 1)
done
