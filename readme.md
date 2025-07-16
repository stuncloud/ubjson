# ubjson

## これはなに

[UWSC掲示板](https://www3.rocketbbs.com/13/bbs.cgi?id=umiumi) の内容をjsonにしたものです

## ファイルについて

- `ub.json`: json化された[UWSC掲示板](https://www3.rocketbbs.com/13/bbs.cgi?id=umiumi)の内容
- `ubjson_gen/ubjson_gen.uws`: `ub.json`を出力するスクリプト
- `ub_old.json`: json化された旧UWSC掲示板の内容
- `ubjson_gen/ubjson_oldboard_gen.uws`: `ub_old.json`を出力するスクリプト
    - umiumiさん製過去ログ検索ツールのhtmlフォルダが別途必要

### jsonファイルの構成

```jsonc
{
    // 掲示板スレッドの配列
    "board": [
        {
            "title": "スレッドのタイトル",
            "author": "スレッド投稿者",
            "no": "スレッド番号 (数値)",
            "datetime": "投稿日時",
            "content": "投稿内容",
            "color": "投稿の色",
            "file": "元のページ番号またはファイル名",
            // レス投稿の配列
            "response": [
                {
                    "thread_no": "スレッド番号 (数値)",
                    "title": "レスのタイトル",
                    "author": "レスの投稿者",
                    "no": "レス番号 (数値)",
                    "datetime": "レス投稿日時",
                    "content": "レス投稿内容",
                    "color": "レス投稿の色"
                },
                {
                    // 上記構成のオブジェクトが続く
                }
            ]
        },
        {
            // 上記構成のオブジェクトが続く
        }
    ],
    // 掲示板過去ログスレッドの配列
    "log": [
        // 構成は掲示板と同じ
    ]
}
```


## 検索ツール

今はまだないです\
いずれ実装したい
