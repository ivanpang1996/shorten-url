#!/bin/bash -e

grep -o ' - - ' access.log | wc -l
