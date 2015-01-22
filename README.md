# webapi-lesson

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
```
