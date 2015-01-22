# webapi-lesson

## ゲーム概要

* ボスを複数人で殴って倒そう。
* キャラクターにはジョブがある。
* ファイターは攻撃力が高く、ヒーラーは回復もできるがヘイトを集めやすい。
* 誰かが行動を取るとボスも攻撃してくる。
* ボスを倒すとクリア。
* キャラクターはいくつでも参戦できる（ひとり１つずつ）


## API 仕様

```
型

Character
  {
    "hp" : Integer,
    "max_hp" : Integer,
    "job" : Job,
    "id" : Integer
  },

Job
  "fighter"
  "healer"


Boss
  {
    "hp" : Integer,
    "max_hp" : Integer
  }

```

```
POST /login

request
  { "username" : String }

response
  {
    "session_id" : Integer,
    "character" : Character,
    "boss" : Boss,
    "session_id" : Integer,
    "activities" : [String]
  }
  
session_id はログイン後のAPIの session_id パラメータに使おう。
activities には、キャラクター・ボスの取った行動ログがすべて入っている。
```

```
POST /create_character

request
  {
    "session_id" : Integer,
    "job" : Job
  }

response
  {
    "character_id" : Integer,
    "characters" : [Character],
    "activities" : [String]
  }
  
キャラクターは1つだけ持てる。
死んでいたら作り直せる。
ジョブを選択することができる。
```

```
POST /attack

request
  {
    "session_id" : Integer
  }

response
  {
    "characters" : [Character],
    "activities" : [String]
  }
```

```
POST /heal

request
  {
    "session_id" : Integer,
    "target_id" : Integer
  }

response
  {
    "characters" : [Character],
    "activities" : [String]
  }
  
target_id に指定したキャラクターを回復できる。
ファイターには使えない。
```
