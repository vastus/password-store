#!/usr/bin/env bash

test_description='Test ls'
cd "$(dirname "$0")" || exit
. ./setup.sh

test_expect_success 'Test "ls" command' "
	$PASS init $KEY1 &&
	$PASS generate yle.fi 16 &&

	$PASS ls &&
	$PASS ls | grep yle.fi
"

test_expect_success 'Test "ls" lists top-level passwords' "
	$PASS generate hs.fi 16 &&

	$PASS ls | grep yle.fi &&
	$PASS ls | grep hs.fi
"

test_expect_success 'Test "ls" lists scoped passwords' "
	$PASS generate Email/yahoo.com 16 &&

	$PASS ls | egrep 'Email\b' &&
	$PASS ls | egrep 'yahoo.com\b'
"

test_expect_success 'Test "ls -1" command' "
	$PASS ls -1
"

test_expect_success 'Test "ls --oneperline" command' "
	$PASS ls --oneperline
"

test_expect_success 'Test "ls -1" lists one entry per line' "
	$PASS ls -1 | grep 'yle.fi' &&
	$PASS ls -1 | grep 'hs.fi' &&
	$PASS ls -1 | grep 'Email/yahoo.com' &&
	[[ $($PASS ls -1 | wc -l) -eq 3 ]]
"

test_expect_success 'Test "ls -1" using path' "
	$PASS ls -1 Email | grep 'yahoo.com' &&
	[[ $($PASS ls -1 Email | wc -l) -eq 1 ]]
"

test_done
