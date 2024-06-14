---
theme: apple-basic
title: なぜRustを選択するのか
highlighter: shiki
drawings:
  persist: true
transition: slide-left
image: "/rust-top.jpg"
layout: intro-image
---

# いつRustを選択するべきか

学習コストが高いRustをなぜ利用するのでしょうか？

<div class="absolute bottom-10">Ama / Yuki Okugawa</div>

---
layout: section
---

# この発表の目的

---
layout: bullets
---

# What is Rust?

<v-clicks>

- パフォーマンス
- 安全性
- 開発体験

</v-clicks>

---
layout: statement
---

# 先進的概念の積極導入

<v-click>
Rustは陶酔する人がとても多い
</v-click>

---
layout: iframe
url: https://survey.stackoverflow.co/2022#section-most-loved-dreaded-and-wanted-programming-scripting-and-markup-languages
---

---
layout: image
image: "/misskey-rust-tweet.png"
---

---
layout: bullets
---

# この発表の目標

<v-clicks>

- 世の中にある**様々な言語機能**を知る。
- Rust を**学習する意義**は？
- Rust の**使いどころ**は？

</v-clicks>

---
layout: section
---

# Rustが便利と思える瞬間

---
layout: image-right
transition: fade
image: "/math2img.png"
---

# Rustで作れるもの

- **コマンドラインツール**
- Web系
    - サーバーサイド
    - フロントエンド
- DSL

---
layout: iframe-right
transition: fade
url: https://docs.rs/axum/latest/axum/
---

# Rustで作れるもの

- コマンドラインツール
- Web系
    - **サーバーサイド**
    - フロントエンド
- DSL

---
layout: iframe-right
transition: fade
url: https://leptos.dev
---

# Rustで作れるもの

- コマンドラインツール
- Web系
    - サーバーサイド
    - **フロントエンド**
- DSL

---
layout: image-right
transition: fade
image: "/amabot.png"
---

# Rustで作れるもの

- コマンドラインツール
- Web系
    - サーバーサイド
    - フロントエンド
- **DSL**

---
layout: two-cols-header
---

# 嬉しい体験

::left::

- **ロジック**を書きやすい
- **ランタイムエラー**が少ない
- **想定通りの動作**をする
- **記法**が豊か

::right::

<v-clicks style="color:teal">

- 多様な**制御構文**
- **所有権と型**が厳しい
- 「**継承より合成**」指向
- 強力な**マクロ**

</v-clicks>

---
layout: section
---

# ポイント

## 1. 制御構文

---

# 制御構文 - 条件分岐

```rust {monaco-run} {autorun:false}
fn main() {
    // if-else
    let x = 5;
    if x < 10 {
        println!("x < 10");
    } else {
        println!("x >= 10");
    }
}
```

---

# 制御構文 - 基本ループ

```rust {monaco-run} {autorun:false}
fn main() {
    // while
    let mut number = 3;
    while number != 0 {
        println!("number: {}", number);
        number -= 1;
    }

    // forループ
    for element in [10, 20, 30, 40, 50] {
        println!("element: {}", element);
    }
}
```

---

# 制御構文 - 無限ループ

```rust {monaco-run} {autorun:false}
fn main() {
    // 無限ループ
    let mut counter = 0;
    loop {
        counter += 1;
        println!("counter: {}", counter);
        if counter == 10 {
            break;
        }
    }
}
```

---
layout: bullets
---

# 便利な制御構文

- パターンマッチ
- 値を返せたり、いつでも脱出できるブロック
- 例外処理方法
- 後置 `await`

---

# 制御構文 - パターンマッチ

<v-clicks>

- 値を比較して**条件分岐**を実現する


```rust {monaco-run} {autorun:false}
fn main() {
    let x: Option<usize> = Some(5);
    match x {
        Some(i) if i > 10 => { println!("i is too many"); },
                  Some(i) => { println!("x is Some({i})"); },
                        _ => { println!("x is None"); },
    }
}
```

<center>

**構造体の中身**も見れる

</center>

</v-clicks>

---

- **変数の束縛**にも使える

```rust {monaco-run} {autorun:false}
fn main() {
    let x: Option<usize> = Some(5);
    let Some(i) = x else {
        println!("x is None");
        return;
    };
    println!("x is Some({i})");
}
```

---

# 制御構文 - ブロック

- ブロックは**スコープを作る**ために使われる。

<v-clicks>

- Rustのブロックは**値を返す**ことができる。

```rust {monaco-run} {autorun:false}
fn main() {
    let x = {
        let y = 3;
        y + 2
    };
    println!("x: {x}");
}
```

</v-clicks>

---

- if-elseにも使える

```rust {monaco-run} {autorun:false}
fn main() {
    let x = if true {
        5
    } else {
        10
    };
    println!("x: {x}");
}
```

<center v-click>

**三項演算子**の代わりに使える

</center>

---

## 名前付きブロック

```rust {monaco-run} {autorun:false}
fn main() {
    let mut x = 0;
    let x_2 = 'outer: {
        'inner: loop {
            x += 1;
            if x == 10 {
                break 'outer x * 2;
            }
        }
    };
    println!("x: {x}, x_2: {x_2}");
}
```

<v-clicks>

- **ラベル**をつけて脱出先を指定できる
- **二重ループ**の脱出などに利用

</v-clicks>

---

# 制御構文 - 例外処理

```rust {monaco-run} {autorun:false}
fn main() {
    let Ok(i) = "5".parse::<i32>() else {
        unreachable!();
    };
    println!("{i}");
    let Err(e) = "abc".parse::<i32>() else {
        unreachable!();
    };
    println!("{e}");
}
```

- `Result`型は`Ok`または`Err`のどちらかを返す型
    - `Result<T, E>`は`Ok(T)`または`Err(E)`

---

<center>

返り値での例外処理は**大域脱出**しにくい

</center>

```go {monaco} {autorun:false}
package main

import (
  "fmt"
  "strconv"
)

func main() {
  i, err := strconv.Atoi("5")
  if err != nil {
    panic(err)
  }
  fmt.Println(i)
  i, err = strconv.Atoi("abc")
  if err != nil {
    panic(err)
  }
  fmt.Println(i)
}
```

---

# 例外処理の考え方

- エラーハンドリングは、<ins>エラーが生じた場所ではなく</ins>、**まとめて一箇所**で行う方がロジックを把握しやすい。
- 予期せぬエラーを防止するために、**コーディング中に起こりうるエラーを把握**したい。

| 方式             | `try-catch` 方式                     | `Result` 型方式        |
| ---------------- | ------------------------------------ | ---------------------- |
| ハンドリング箇所 | 上層に返す(○)                       | その場で対応(△)       |
| エラー発生箇所   | プログラマーが把握する必要がある(△) | 構文的に明示される(○) |

---

# `?`演算子

```rust {monaco}
fn parse_test() -> Result<(), std::num::ParseIntError> {
    let i = "5".parse::<i32>()?;
    println!("{i}"); // 5
    let i = "abc".parse::<i32>()?;
    println!("{i}"); // ここには到達しない
}
```

- `?`演算子は`Result`型を返す関数内でのみ利用可能
- `Result`型が`Ok`なら`Ok`の中身を返し、`Err`ならそのまま`Err`を返す

<center>

大まかなロジックの見た目を汚すことなくエラーを纏める

</center>

---

# 制御構文 - 後置 `await`

```ts {monaco}
async function main() {
    const response = await fetch('https://example.com');
    const text = await response.text();
    console.log(text);
}
```

<v-clicks>

```ts {monaco}
async function main() {
    console.log(await (await fetch('https://example.com')).text());
}
```

<center>

たくさんの`await` → たくさんの `(await (await ...))`

</center>

</v-clicks>

---

- 後置だと解決！

```rust {monaco}
async fn main() -> Result<(), Box<dyn Error>> {
    println!("{}", reqwest::get("https://example.com").await?.text().await?);
    Ok(())
}
```

<center v-click>

たくさんの`await` → たくさんの `.await?.await?`

</center>

---
layout: section
---

# ポイント

## 2. 所有権と型

---
layout: section
---

# ポイント

## 3. 継承より合成 

---
layout: section
---

# ポイント

## 4. マクロ

