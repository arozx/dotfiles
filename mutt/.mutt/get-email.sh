#!/bin/bash

set -euo pipefail

PASS_ENTRY="email/mutt/arozx@disr.it"

exec pass show "$PASS_ENTRY"
