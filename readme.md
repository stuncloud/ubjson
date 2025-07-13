# ubjson

## これはなに

[UWSC掲示板](https://www3.rocketbbs.com/13/bbs.cgi?id=umiumi) の内容をjsonにしたものです

## ファイルについて

- `ub.json`: json化された[UWSC掲示板](https://www3.rocketbbs.com/13/bbs.cgi?id=umiumi)の内容
- `ubjson_gen/ubjson_gen.uws`: `ub.json`を出力するスクリプト

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

## 旧掲示板について

アクセス手段がないので含まれていません
旧掲示板のログをお持ちの方がいたらご連絡ください

## 検索ツール

今はまだないです
いずれ実装したい