#!/bin/bash 
ng () {                               # 関数ngの定義（P18と同じ）
    echo ${1}行目のテスト失敗
    res=1                          # 失敗したことを記録
}

res=0                                  # 0: 失敗なし（ngが呼ばれると1になる）

### NORMAL INPUT ###
out=$(seq 5 | ./bigprint)
[ "$?" = 0 ]      || ng "$LINENO"
[ "${out}" = 15 ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo あいう | ./bigprint)    #表示できない値を入力してみる
[ "$?" = 1 ]      || ng "$LINENO" #終了ステータスが1なのを確認
[ "${out}" = "" ] || ng "$LINENO" 

out=$(echo | ./bigprint)          #なにも入力しない
[ "$?" = 1 ]      || ng "$LINENO" #異常終了する
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res