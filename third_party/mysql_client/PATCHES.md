# Foxy mysql_client fork

This directory contains the runtime sources from `mysql_client` 0.0.27.
The upstream license is preserved in `LICENSE`.

Foxy carries one protocol change while upstream has no connection option for
it: `CLIENT_FOUND_ROWS` is included in both plain and TLS handshake capability
flags. MySQL then reports rows matched by `UPDATE`, including unchanged rows,
instead of only rows whose values changed.

This behavior is required by `database_write_result_plan.md` so repositories
can distinguish an unchanged existing row from a missing original row without
an additional racy query.
