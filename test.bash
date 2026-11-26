#!/bin/bash 
# SPDX-FileCopyrightText: 2026 Keiji Fujie
# SPDX-License-Identifier: BSD-3-Clause
ng () {
    echo ${1}行目のテスト失敗
    res=1
}

res=0

### NORMAL INPUT ###
# 引数入力: 7行で出力される
out=$(./bigprint A)
[ "$?" = 0 ]                       || ng "$LINENO"
[ "$(echo "$out" | wc -l)" = 7 ]   || ng "$LINENO"

# -c で指定した記号が使われ、デフォルトの # は使われない
out=$(./bigprint -c '@' A)
[ "$?" = 0 ]                       || ng "$LINENO"
echo "$out" | grep -q '@'          || ng "$LINENO"
echo "$out" | grep -q '#'          && ng "$LINENO"

# 標準入力 + -c
out=$(echo AB | ./bigprint -c '@')
[ "$?" = 0 ]                       || ng "$LINENO"
echo "$out" | grep -q '@'          || ng "$LINENO"

# 全角の記号を指定しても動く
out=$(./bigprint -c '■' A)
[ "$?" = 0 ]                       || ng "$LINENO"
echo "$out" | grep -q '■'          || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo あいう | ./bigprint)    # 表示できない値を入力してみる
[ "$?" = 1 ]      || ng "$LINENO"  # 終了ステータスが1なのを確認
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo | ./bigprint)           # なにも入力しない
[ "$?" = 1 ]      || ng "$LINENO"  # 異常終了する
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res