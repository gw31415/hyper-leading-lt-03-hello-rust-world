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

