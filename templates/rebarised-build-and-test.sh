#!/bin/sh

set -e

./rebar get-deps
./rebar compile
./rebar xref
./rebar eunit apps=pclass_static
