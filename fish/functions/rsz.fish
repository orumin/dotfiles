function rsz
    if test -t 0 -a (count $argv) -eq 0
        # 現在のカーソル位置を保存し，ターミナル右端へカーソルを移動
        # そのカーソル位置の情報を報告したのち，カーソル位置を元に戻す
        # という内容のエスケープシーケンス
        # \e7 ... DECSC (Save Cursor)
        # \e[r ... DECSTBM (Set Top Bottom Margins)
        # \e[999;999H ... 999行999列へのCUP (Cursor Position)
        # \e[6n ... DSR (Device Status Reports)
        # \e8 ... DECRC (Restore Cursor)
        # https://zariganitosh.hatenablog.jp/entry/20150224/escape_sequence

        # 上記の結果 ^[[80;25R といった文字列が得られるはずなので
        # これが使用しているターミナルのサイズになる
        
        # fish は 1 行ごとに勝手に stty の状態を戻すのでいくつかのコマンドをまとめる
        # エコーバックを無効化してからエスケープシーケンスを送ることで，\e[6n の出力が標準出力に残ったままになり待ち状態になる
        # 次に続くコマンドでこれを入力として処理，数字部分だけ取り出して x と y に格納
        # https://unix.stackexchange.com/a/88327
		# https://unix.stackexchange.com/a/388606
        set oldstty (stty -g)
        stty -icanon -echo min 1 time 0; printf '\e7\e[r\e[999;999H\e[6n\e8'; awk -F'[^0-9]+' -v RS=R '{print $3, $2; exit}' | read x y
        stty "$oldstty"

        if test $COLUMNS -eq $x -a $LINES -eq $y
            printf "$TERM {$x}x{$y}"
        else
            printf "{$COLUMNS}x{$LINES} -> {$x}x{$y}"
            stty cols $x rows $y
        end
    else
        printf "Usage: rsz"
    end
end
