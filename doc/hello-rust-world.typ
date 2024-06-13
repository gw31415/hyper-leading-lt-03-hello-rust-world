#import "./template.typ": *

#show: template.with(
  title: [いつRustを選択するべきか], author: [Ama / Yuki Okugawa], bib: "hello-rust-world.bib",
)

= この発表の目的

Rustは*パフォーマンス*・*安全性*・*開発体験*を重視したプログラミング言語として開発されています
@rust-lang
。このような宣伝文句を掲げる言語は山のようにありますが、Rustの特徴としては#underline[言語仕様に先進的な概念を積極的に導入している]点が大きいです。

このため、#underline[Rustは陶酔する人がとても多い]言語でもあります。Stack
Overflow Developer Survey では「最も愛されているプログラミング言語(Loved vs.
Dreaded)」 部門で2016-2022の7年間首位 @stackoverflow-survey-2022
、2023年に基準が変わりました @stackoverflow-survey-2023
がそれも首位になりました。同時に、プロジェクトに導入を検討したのみで炎上したプロジェクトも存在します
@misskey-rs 。

今回の第一目標は、Rustを学ぶことを通して、*プログラミング言語における先進的概念にはどのようなものがあるのかを知る*ことです。また、Rustを学んだことがない人を対象に、*Rustを学習する意義について想像できるようになること*も次なる目標です。Rustを齧ったことがある人には、*Rustの使いどころについて考えるきっかけ*になってほしいと思います。Rust有識者は*怒らないでください*。

= Rustが便利と思える瞬間

== Rustでどのような物が作れるのか

Rustは元々バックエンドを開発するようなフィールドをカバーし、C/C++の代替言語として注目されていました。このため、*コマンドラインツール*を作成したり、*組み込み用プログラム*を書くことに適した言語としても知られています。

しかしながら、WebAssemblyをサポートしたことでブラウザサイドの計算部分に用いられるようになりました。それを皮切りに#link("https://yew.rs/ja/")[Yew]が開発され、他にも#link("https://leptos.dev")[Leptos]など、*フロントエンド*開発にも使えるフレームワークが登場し、Web系のフロントエンドにも使えるものも増えてきました。

また、強力なマクロ(後述)によって*メタプログラミング*にも適し、各種*DSL*との連携も容易に行うことができます。例えばDiscordのAPIを叩く際、APIを直接叩く方法を記述すると、スラッシュコマンドを定義するだけでも以下のような動作を記述する必要があります。
- 引数をJSONで定義する
- リクエストを待ち受けるハンドラを定義
- さらにその両者のコードは別の部分に書く必要がある
これらはビジネスロジックとは関係ない部分であり、コードの可読性が下がります。Rustをはじめとするマクロが強力な言語は、マクロを使うことで#underline[必要ない部分を隠蔽し、見たい部分だけを記述する]ことで直感的で簡潔なコードにすることができます。
「マクロは便利なのは分かったけどマクロって何なの？」詳しくは後述しますが、#underline[マクロとはコンパイル前にソースコードを別のソースコードに変換することができる仕組み]です。

=== Rustの利用例

- React-likeなWebフレームワーク: #link("https://leptos.dev")[Leptos]
- Discord Botフレームワーク: #link("https://github.com/serenity-rs/poise")[Poise]
- シリアライズ/デシリアライズライブラリ: #link("https://serde.rs/")[Serde]

==== Amaが作ったもの

- CLIツール: `sxp`, `math2img`
  - `sxp`: `cairo` を用いてPDFをSVGに変換したり戻すツール。講義のスライドの穴開き部分を復旧するために作った
  - `math2img`:数式を画像に変換するCLIツール。Amabotの数式描画部分をライブラリ化してCLI化した
- 数独を解く計算ライブラリ: #link("https://github.com/gw31415/number_place")[`number_place`]
  - WebAssembly版: #link(
      "https://gw31415.github.io/number_place.js/",
    )[https://gw31415.github.io/number_place.js/]
  - 居眠りしてたら計算機的に解くアプローチを思いついたので作ってみたもの(後に知ったが制約伝播という方法だった)
- PGNを見るサイト: #link("https://pgn.amas.dev/")[https://pgn.amas.dev/]
- Discord Bot: #link("https://github.com/gw31415/amabot/")[Amabot]
  - 数式描画機能を実装したDiscord bot
  - `v8`を内蔵し、`mathjax`を叩いて数式を画像に変換するアプローチ

== Rustの開発で嬉しい体験

- 思いどおりのロジックを書きやすい。
- ランタイムエラーを起こしにくい。
- 想定外の動作に出会いにくい。
- 記法が豊かなフレームワークが多数ある。

== その体験を生み出しているポイント

- 多様な*制御構文*
- 意識せざるを得ない*所有権*と厳格な*型*
- 継承より合成 (Composition over Inheritance)
- 強力な*マクロ*

=== 制御構文

Rustでは、他の多くのプログラミング言語と同様*if-else条件分岐*、
*for/whileループ*、*loop無限ループ*をサポートしています。
```rust
fn main() {
    // if-else
    let x = 5;
    if x < 10 {
        println!("x < 10");
    } else {
        println!("x >= 10");
    }

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
他に、以下の構文が便利になっています。これらは採用している言語が一部か、もしくはRust以外でほとんど見られないものです。
- パターンマッチ
- 値を返せたり、いつでも脱出できるブロック
- 例外処理方法
- 後置`await`
以下では、これらの構文について詳しく説明したいと思います。

==== パターンマッチ

PythonやJavaScriptを触ったことがある人は、`switch`文を使ったことがあるかもしれません。Rustには`switch`文はありませんが、`match`文があります。`match`文は`switch`と同じように、値が等しいかどうかで条件分岐を行うこともできます。ただし、`match`文が強力なのは、値の比較だけでなく、*パターンマッチング*ができることです。パターンマッチが一般の条件分岐より強力たらしめるのは、#underline[構造体や列挙型など多階層の値に対しても1度にマッチしたかどうかを判定できること]です。
```rust
fn main() {
    let x: Option<usize> = Some(5);
    match x {
        Some(i) if i > 10 => { println!("i is too many"); },
                  Some(i) => { println!("x is Some({i})"); },
                        _ => { println!("x is None"); },
    }
}
```
パターンマッチが使えるのは `match` による条件分岐のみではなく、変数の束縛にも使えます。例えば、以下のコードは`Some(5)`の値を`i`に束縛しています。
```rust
fn main() {
    let x: Option<usize> = Some(5);
    let Some(i) = x else {
        panic!("x is None");
    };
    println!("x is Some({i})");
}
```

==== 値を返せたり、いつでも脱出できるブロック

Rustのブロックは、他の多くの言語と同様に*スコープを作るため*に使われます。しかし、Rustのブロックは*値を返すことができる*という特徴があります。これは、#underline[ブロックの最後に書かれた式がそのブロックの値として返される]という仕様です。例えば、以下のコードは`x`に`5`が代入されます。
```rust
fn main() {
    let x = {
        let y = 3;
        y + 2
    };
    println!("x: {x}");  // x: 5
}
```
これは単純な`{}`によるブロックだけでなく、`if`や`match`文のブロックでも使うことができます。例えば、以下のコードは`x`に`5`が代入されます。普段使う `if` が*三項演算子*のように使えるとイメージしていただければ良いと思います。
```rust
fn main() {
    let x = if true {
        5
    } else {
        10
    };
    println!("x: {x}");  // x: 5
}
```
また、ブロックにはラベルをつけることができ、`break`文でそのラベルを指定することで、#underline[いつでも脱出できる]という特徴があります。`break`に値を渡すことで、指定したブロックに値を返させることもできます。
```rust
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
    println!("x: {x}, x_2: {x_2}");  // x: 10, x_2: 20
}
```

==== 例外処理

多くの言語では、例外は`try-catch`構文によって処理されます。`try-catch`を基本とした例外処理では、順次実行される文のどこかで例外がスローされ、`try`で囲まれたブロックに到達するまでスタックを巻き戻していきます。

Rustでは回復不能なエラーと回復可能なエラーが明確に区別されています。前者は`panic`を起こして終了しますが、後者は`Result`という列挙型(`enum`: `Result<T, E>`は`Ok(T)`もしくは`Err(T)`であることを表す)として通常の値と同じように値として関数の返り値として扱われます。Rustでは回復不能なエラーをキャッチする方法で回復する方法は避けられています。
```rust
fn main() {
    let Ok(i) = "5".parse::<i32>() else {
        unreachable!();
    };
    println!("{i}"); // 5
    let Err(e) = "abc".parse::<i32>() else {
        unreachable!();
    };
    println!("{e}"); // "invalid digit found in string"
}
```
回復可能なエラーをきちんと返り値として扱うと想定外な動作を作りにくくなるメリットがあります。エラーが文法上一緒に扱われていると、呼び出している関数全てに関して停止するかどうかを把握しないといつ停止するか分からないためです。返り値として`Result`が用いられると、(回復可能な)エラーの可能性が型として明示されるため、文法の範疇で対応を強制されます。

ただ、返り値としてエラーを返すということは*大域脱出*しにくいということを意味します。例えば、同様に返り値としてエラーを扱うGo言語によるエラーハンドリングは以下のようになります。
```go
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
このように、エラーが値として返ってくる分、*その場で対処を書かないとエラーを無視する*ことになってしまいます。これは、#underline[発生しうるエラーをプログラマーに気付かせる]メリットがある反面、#underline[エラーハンドリングをロジック内に割り込んで書かざるを得ず]、大まかな動作を把握しづらいコードが生まれがちです。

- エラーハンドリングは、エラーが生じた場所ではなく、まとめて一箇所で行う方がロジックを把握しやすい。
- 予期せぬエラーを防止するために、コーディング中にプログラマーが起こりうるエラーを把握したい。

#{
  show table.cell.where(y: 0): strong
  table(
    columns: (1fr, 1fr, 2fr), table.header(
      [方式], [ハンドリング箇所], [エラー発生箇所], //
    ), [`try-catch`方式], [上層に返す(○)], [プログラマーが把握する必要がある(△)], //
    [`Result`型方式], [その場で対応(△)], [構文的に明示される(○)], //
  )
}

Rustでは、`Result`を返す関数内でのみ使える`?`演算子があります。これは、`Result`が`Ok`なら`Ok`の値をアンラップし、`Err`ならその`Err`を即時`return`するという演算子です。これにより、エラーが発生した場合は即座にエラーを返して関数を終了することができます。以下のように、大まかなロジックの見た目を汚すことなくエラーを纏めることができます。
```rust
fn parse_test() -> Result<(), std::num::ParseIntError> {
    let i = "5".parse::<i32>()?;
    println!("{i}"); // 5
    let i = "abc".parse::<i32>()?;
    println!("{i}"); // ここには到達しない
}
```

==== 後置await

並行処理の記述のために便利な記法として、様々なプログラミング言語で `async` / `await` を利用することができます。例えば、以下のコードは`async`関数内で`await`を使って非同期処理を行っています。
```javascript
async function main() {
    const response = await fetch('https://example.com');
    const text = await response.text();
    console.log(text);
}
```
`await`を用いると、非同期な関数をロジック内に記述する際に、「非同期処理が終わるまで待機する」ような感覚で非同期処理を混ぜ込んだコードを書くことができるのです。

ただし先程のように、`await`は前置記法なのでしばしば不便な場面があります。例えば、先程のコードを一行で書いてみましょう。
```javascript
async function main() {
    console.log(await (await fetch('https://example.com')).text());
}
```
`await`が前置記法の場合、非同期処理が多重になった際に`()`を用いて親子関係を明示する必要が出てくるのです。冗長なコードに見えると思います。

Rustの場合、`await`には後置記法が採用されています。先程のコードをRustで書いてみましょう。
```rust
async fn main() -> Result<(), Box<dyn Error>> {
    println!("{}", reqwest::get("https://example.com").await?.text().await?);
    Ok(())
}
```
このように、`await`を後置記法で書くことができるため、非同期処理が多重になっても`()`を用いる必要がなく、コードがすっきりと書けるようになります。読む際も左から右へと読むことができるため、コードの可読性が向上します。関数型言語によく見られる*メソッドチェーン*からの影響を受けています。

=== 所有権 & 型

Rustには変数と値の間に*所有権*の概念があります。値は所有される変数がただ一つであり、値の共有はデフォルトではできません(明示的にスマートポインタ等でラップする必要がある)。

所有権があると何が嬉しいのか。所有権が明確でない言語によくある特徴として、「値のコピー」「代入」「値の共有」が構文で区別されていないという点があります。例えば、Pythonで以下のようなコードを考えます。
```python
a = "hello"
b = a
b = "world"
print(a)  # "hello"

a = [1, 2, 3]
b = a
b[0] = 4
print(a)  # [4, 2, 3]
```
この出力は、#underline[文字列の場合は`b = a`で`a`の値がコピー]され、#underline[リストの場合は`b = a`で`a`の値が共有]されていることによって起こります。この仕様は*変数に与えている値によって動作が変わってしまう*ということを意味します。

Rustの場合は、所有権の概念があるため、このような問題が起こりにくいような文法になっています。例えば、Rustで同様のコードを書くと以下のようになりそうです。
```rust
//! WARNING: このコードはコンパイルできません
let a = String::from("hello");
let mut b = a;
b = String::from("world");
println!("{:?}", a);

let mut a = vec![1, 2, 3];
let b = &a;
a[0] = 4;
println!("{:?}", b);
```
しかし、*上記のコードはコンパイルすることができません*。#underline[Rustは`=`の演算子で値の所有権が移動します]。 `a`の所有権が`b`に移動した後に`a`を参照することができなくなるため、上記の構文は文法エラーになるのです。

プログラマーは、他の変数を元に変数の値を決定する際、以下の複数の選択肢があり、Rustではこれらを明確に区別しないとコードが書けないようになっています。
- 値の所有権の移動
- 値のコピー
- 値の共有

==== 所有権の移動

値を `a` から `b` に移動したい時、`b` に `a` を代入することで所有権を移動することができます。この時、`a` は所有権を失い、`b` が所有権を持つようになります。ただ値が移動するだけで、値のコピーは行われません。これを*ムーブセマンティクス*と言います。

```rust
let a = String::from("hello");
let b = a;
// これ以降 a は使えない
```

==== 値のコピー

値を `a` から `b` にコピーしたい時、値の `clone` メソッドを呼び出すことでコピーすることができます。この時、元の値はそのまま残り、コピーされた値が新たに作られます。

```rust
let mut a = String::from("hello");
let b = a.clone();

a.push_str("world");

println!("{:?}", a);  // "helloworld"
println!("{:?}", b);  // "hello"
```

===== 所有権の移動ではなくコピーをデフォルトにしてほしい時

このようにRustでは、所有権の移動がデフォルトであり、値のコピーは明示的に行う必要があります。しかし、`Copy`トレイトを指定した型はデフォルトでコピーされるように変更されます。`Copy`トレイトを実装している型は、スタックに置かれるような小さなサイズの型を指定するのが望ましいでしょう。デフォルトではAtomicな型に主に`Copy`トレイトが実装されています。つまり、`Copy`トレイトを実装している型についてはムーブセマンティクスではなく*コピーセマンティクス*が適用されるようになると言えます。

==== 値の共有

値を共有したい際はかなり厄介です。メモリ安全性の観点や並列処理の観点から、値の共有は昔から多くのバグを生みだしてきました。

メモリ安全性というのは平たく言えば、#underline[値を保持しているポインタの管理方法が適切でバグを生みださない]、ということです。例えば、大規模なプログラムを作成する際、メモリを適宜開放しないとメモリが枯渇してしまいます。しかし、一度開放したアドレスに対してもう一度メモリ開放を行うと、深刻なバグが生み出されます(*二重解放エラー*)。どれだけ深刻かというと、*サービスの停止*、*情報漏洩*、*任意コード実行*まで行われる可能性があります。メモリ安全性はセキュリティの文脈でかなり重要です。Microsoftによる2019年の発表によると、過去12年間で対処したセキュリテイバグの70％がメモリ安全性の問題だった
@ms-bugs
としています。メモリリーク系統のバグは二重解放エラーのみではなく、以下に挙げる
@mem-errors ように多岐にわたります。
- *アクセスエラー*: 無効なポインタの読み取り・書き込み
  - バッファオーバーフロー: 範囲外の書き込み
  - バッファオーバーリード: 範囲外の読み取り
  - 競合状態: 同時に読み書き
  - 無効ページフォールト: 未定義ポインタへのアクセス
  - 解放後使用: ダングリングポインタの参照
- *未初期化変数*: 定義されていない変数の使用
  - ヌルポインタの参照外し: 無効なポインタの参照
  - ワイルドポインタ: 初期化前のポインタ使用
- *メモリリーク*: メモリ使用量の追跡ミス
  - スタックの枯渇: 深い再帰呼出し
  - ヒープの枯渇: メモリ過剰確保
  - 二重解放: 同じアドレスの再解放
  - 無効な解放: 無効なアドレスの解放
  - 不一致な解放: 異なるアロケータの使用
これら全てを把握してメモリ管理を考える必要があるわけです。

C/C++やZigでは、メモリ管理はプログラマが責任を負って行う必要があります。このため、意図せずメモリ安全性を侵すコードが入り込むことが多く、バグの原因となります。GoやPython、他の多くの高級言語ではプログラム実行と同時に*ガベージコレクタ*が別スレッド(またはタスク)で起動し、用いられなくなった値を自動検出して開放しメモリ管理を行うため、メモリ安全性の問題は発生しにくいです。しかし、ガベージコレクタ自体がメモリや計算資源を浪費し、また成果物も巨大になってしまいます。

Rustでは、スコープから外れた変数は自動的にドロップ操作が呼ばれたと見做され、自動的にメモリ開放されます。#underline[所有権の概念によってコンパイラが数学的にメモリ安全性を保証]しているのでこの操作を行ってもメモリ安全性が侵されません。所有権ルールを守りさえすれば、*ガベージコレクションなし*でも、値がどこにあるか意識しなくてもメモリの安全性が保証され、メモリが適切に管理されたプログラムを書くことができるのです。

しかし、所有権ルールを侵さないコードを書くのは最初は難しいかもしれません。これが、#underline[Rustの学習が難しいと言われる理由の1つ]でもあります。単に「値を共有する」だけでも用途によって多数の型を使い分けなければなりません。
#image("rust-memory-container-cs-3840x2160-white-back-black-ink.png")
この中から選定することは確かに難しいですが、用途に応じて必要そうなものを選び、入れ子にしていけばいつか必要な型が見つかるでしょう。少なくとも、*コンパイラが許したということは、その変数は安全に使えている*ということです。

例として、異なるスレッドからアクセスできる共有メモリの例を示します。このプログラムは、10個のスレッドを生成し、それぞれのスレッドで1秒間スリープした後に共有された変数`count`をインクリメントします。それぞれのスレッドで独立して1秒間スリープするため、このプログラムは約1秒で終了するはずです。以下のコードは`Mutex`を用いてスレッド間で共有メモリを実現しており、メモリ安全です。

```rust
use std::{
    io::{stdout, Write as _},
    sync::{Arc, Mutex},
    thread,
    time::Duration,
};

fn main() {
    println!("Started.");
    let count = Arc::new(Mutex::new(0));
    let mut threads = vec![];

    for _ in 0..10 {
        // Arcをクローン
        let count = count.clone();

        // 新規スレッドを生成
        threads.push(thread::spawn(move || {
            thread::sleep(Duration::from_secs(1));
            let mut count = count.lock().unwrap(); // Mutexをロックしてアクセス
            *count += 1;
            println!("Count: {}", count);
            stdout().flush().unwrap();
        }));
    }

    // スレッドの待ち合わせ
    for t in threads {
        t.join().unwrap();
    }
}
```

=== 継承より合成

Rustは*マルチパラダイム*な言語と言って、オブジェクト指向や式指向など、様々な書きかたができるプログラミング言語です。Rustではオブジェクト指向的書き方で開発をすることもよくあります。

オブジェクト指向プログラミングとは、様々な事柄を「オブジェクト」として考えるプログラミング手法です。例えば、複素数について扱いたい場合に実部と虚部を1つにまとめて「複素数」という型を作成し、複素数に対して使える関数を定義することでオブジェクトを起点にロジックを纏めていくことで細かい計算部分を隠蔽することができます。

型を新しく作成する際、別の型とよく似た型を作成したいことがあると思います。例えば、Animalというクラスが既にあった場合、Dogというクラスを作成したいと思うかもしれません。この場合、DogはAnimalとして扱えたら便利です。このような機能を実現するために、多くの言語では*継承*という機能が用いられます。継承は、既存のクラスを拡張する形で新しいクラスを作成します。

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        print(f"{self.name} is speaking.")

class Dog(Animal):
    def __init__(self, name):
        super().__init__(name)

    def bark(self):
        print(f"{self.name} is barking.")

dog = Dog("Pochi")
dog.speak()  # "Pochi is speaking."
```

しかし、継承は*継承の階層が深くなると複雑になりがち*です。例えば、Animalクラスを継承したDogクラスをさらに継承したPoodleクラスを作成する場合、PoodleクラスはAnimalクラスのメソッドを持つことになります。このようにして、親から子、孫、ひ孫と継承していくと、*継承の階層が深くなりすぎてしまう*ことがあります。継承の階層が深くなると、*どのクラスがどのメソッドを持っているのか*が分かりにくくなり、コードの保守性が下がります。

Rustでは、継承よりも*合成*を推奨しています。合成とは、既存のクラスを拡張する形で新しいクラスを作成するのではなく、持っていてほしい「特徴」を合成していく形で新しいクラスを作成する手法です。その特徴のことを*トレイト*と呼びます。トレイトは、クラスに対して特定の機能を提供するためのインターフェースのようなものです。これにより、*継承の階層が深くなることを防ぎつつ、クラスに特定の機能を追加する*ことができます。

```rust
trait Animal {
    fn speak(&self);
}

struct Dog {
    name: String,
}

impl Animal for Dog {
    fn speak(&self) {
        println!("{name} is speaking.");
    }
}
```

Rustでは、トレイト機能が様々な場面で使われています。例えば、`Copy`トレイトを実装している型は、ムーブセマンティクスではなくコピーセマンティクスが適用されるようになります。また、*演算子のオーバーロードもトレイトを用いて行われます*。例えば、`+`演算子は`Add`トレイトを実装している型に対して使うことができます。

```rust
use std::ops::Add;

struct Complex {
    real: f64,
    imag: f64,
}

impl Add for Complex {
    type Output = Complex;

    fn add(self, other: Complex) -> Complex {
        Complex {
            real: self.real + other.real,
            imag: self.imag + other.imag,
        }
    }
}

fn main() {
    let a = Complex {
        real: 1.0,
        imag: 2.0,
    };
    let b = Complex {
        real: 3.0,
        imag: 4.0,
    };
    let c = a + b;
    println!("{} + {}i", c.real, c.imag); // 4 + 6i
}
```

=== マクロ

マクロは、プログラムの中でプログラムを生成する機能です。マクロはRustソースコードを生成することができる機能のことですが、今回はその言語仕様について深く立ち入ることは割愛します。マクロを用いると以下のようなソースコードもRustとしてコンパイルすることができるのです。

```rust
// MIT License
// Copyright (c) 2021 kangalioo
// https://github.com/serenity-rs/poise/blob/c67dde58e2a185193738b30f2b1e8600dcf391cd/examples/quickstart/main.rs

/// Displays your or another user's account creation date
#[poise::command(slash_command, prefix_command)]
async fn age(
    ctx: Context<'_>,
    #[description = "Selected user"] user: Option<serenity::User>,
) -> Result<(), Error> {
    let u = user.as_ref().unwrap_or_else(|| ctx.author());
    let response = format!("{}'s account was created at {}", u.name, u.created_at());
    ctx.say(response).await?;
    Ok(())
}
```
#image("discord-cmd-using.png")
#image("discord-cmd-used.png")

```rust
// MIT License
// Copyright (c) 2022 Greg Johnston

use leptos::*;

#[component]
pub fn SimpleCounter(initial_value: i32) -> impl IntoView {
    // create a reactive signal with the initial value
    let (value, set_value) = create_signal(initial_value);

    // create event handlers for our buttons
    // note that `value` and `set_value` are `Copy`,
    // so it's super easy to move them into closures
    let clear = move |_| set_value(0);
    let decrement = move |_| set_value.update(|value| *value -= 1);
    let increment = move |_| set_value.update(|value| *value += 1);

    // create user interfaces with the declarative `view!` macro
    view! {
        <div>
            <button on:click=clear>Clear</button>
            <button on:click=decrement>-1</button>
            // text nodes can be quoted for additional control over formatting
            <span>"Value: " {value} "!"</span>
            <button on:click=increment>+1</button>
        </div>
    }
}

pub fn main() {
    mount_to_body(|| {
        view! {
            <SimpleCounter initial_value=3 />
        }
    })
}
```

= Rustが不便なとき

Rustにはこれまで挙げたように様々な言語機能があり、それぞれ頭の中の設計を落とし込みやすい便利な側面がありますが、巷でRust製のプロジェクトを目にすることはそこまで多くないと思います。大規模なプロジェクトに採用しづらい理由があるのです。

== Rustの言語的なコスト

Rustの学習コストは*とても高い*と言われています。情報が少ないような最近の概念を取り入れているので、他の言語にないような概念が多々存在しているためです。特に、メモリ管理を扱うための*所有権、借用、ライフタイム*などの概念にはあらゆるコードで求められるため逃げられませんが、これらの概念は他の言語にはないものです。

チーム開発としては、全員がある程度以上のレベルでRustを理解する必要が出てきますが、全員にその習熟を求めるのはビジネス的観点からするとメリットを見出せないことが多いです。Rustのプロジェクトは習熟時間も長く、メンテナンスコストも高く、その分人件費が嵩むことが予想されるでしょう。また、Rustはコンパイラが厳格で、#underline[ランタイムエラーを可能な限り減らし、できるだけコンパイルエラーで扱う]という方針です。裏を返せば、*他の言語で求められない安全度にするまで動作すらしない*ということを意味します。リリースまでに時間がかかるということになり、ビジネス的には不利に働くことが多いです。

== 重すぎるコンパイラと型チェック

Rustには*厳格な型チェック*があり、*マクロも高機能*になっています。そのため、*コンパイラが非常に重く、コンパイル時間が長く*なっています。これによって#underline[開発時の計算リソースや時間を大幅に浪費]してしまいます。Web系の開発だとDockerなどコンテナで開発することが多くなると思いますが、#underline[コンテナ内でコンパイルを繰り返すととんでもない時間が要求]されます。

== 円熟したライブラリの不足

Rustは標準ライブラリをできるだけ少なくする方針が取られています。例えば*時刻系*のライブラリ、*並行処理のランタイム*、*乱数系*のライブラリなどは標準ライブラリには含まれていません。そのため、#underline[ライブラリの選定の回数]が多くなります。また、#underline[1つ1つの選定も難しい]です。Rustの開発者は円熟していない前衛的な思想もガンガン取り入れる人が多いので、破壊的な変更もとても多くなっています。そのため、ライブラリ周辺で安定しないことも時々あります。

= Rustの使い所

Rustのメリットとデメリットを説明してきました。結局どんな時にRustを使うべきなのでしょうか。

== サービスが世界レベルで大規模な場合

Rustは他の言語を圧倒する高いパフォーマンスのポテンシャルと安全性があります。これによって、*サービスが世界レベルで大規模*な場合、Rustを採用すると大きな利益を生む場合があります。例えば、DiscordはRustを採用することで、サーバーの負荷を大幅に軽減することができたことが知られています @discord-rust 。

== 組み込み系のプログラム

組み込み系のプログラムは、*リソースが限られている*ため、高いパフォーマンスが求められます。また、#underline[組み込み系のプログラムはアップデート頻度が比較的低い]ことを考えれば、*1回の成果物で安全性をある程度担保されている*Rustで開発するのは理にかなっていると思います。もちろん、#underline[アップデートが破壊的になされるライブラリを用いず、標準ライブラリを基本として使うことが必要]にはなりそうです。

== ビジネスではないプロジェクト

Rustはビジネス周辺での利用が難しくなると述べました。裏を返せば、*無限に時間が使えて*、*営利性を求めない*ようなプロジェクトはRustを利用すると利益を大きく得られると思います。例えば、*OSSの開発や個人開発*で利用すると良いと思います。
