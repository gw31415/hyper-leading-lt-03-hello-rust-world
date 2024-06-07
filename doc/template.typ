#import "@preview/codelst:2.0.1": sourcecode

#let template(doc, title: none, author: none, bib: none) = {
  let printableAscii = "[\p{ascii}&&\P{C}]"

  let mixedBold(body) = {
    set text(font: "Hiragino Sans", weight: "light")
    show regex(printableAscii): set text(font: "Times New Roman", weight: "bold")
    body
  }

  set text(font: "Hiragino Mincho ProN", weight: "regular", size: 10.5pt)

  // TODO: raw.where(block: true)でHackGen Console NFにならない問題
  // show regex(printableAscii): set text(font: "Times New Roman", size: 1.15em)

  show strong: it => {
    set text(weight: "thin")
    mixedBold(it)
  }
  set heading(numbering: "1.")
  show heading: it => {
    mixedBold(it)
    par(text(size: 0pt, ""))
  }
  show outline: it => {
    set par(first-line-indent: 0pt)
    it
  }
  show link: it => {
    set text(blue)
    underline(it)
  }
  show raw.where(block: false): box.with(
    fill: luma(240), inset: (x: 4pt, y: 0pt), outset: (x: -2pt, y: 2pt), radius: 2pt,
  )
  show raw.where(block: true) : it => {
    set text(font: "HackGen Console NF", weight: "regular", size: 10.5pt)
    sourcecode(numbers-style: i => text(fill: luma(180), i), it)
  }

  set par(first-line-indent: 1em)

  set page(numbering: "1")

  set outline(title: "目次", depth: 4)

  let titlepage(title: content, author: content) = {
    pagebreak(weak: true)
    set page(numbering: none)
    set align(center)
    v(1fr)
    text(size: 2em, mixedBold(title))
    v(1em)
    author
    v(1fr)
    outline()
    v(1fr)
  }

  if title != none {
    titlepage(title: title, author: author)
  }

  doc

  if bib != none {
    bibliography(
      bib, style: "association-for-computing-machinery", title: "参考文献", full: true,
    )
  }
}
