---
name: tui-visual-explainer
description: Generate ASCII/Unicode diagrams directly in the terminal using diagon. Supports flowchart, sequence, table, tree, graph (DAG), grammar (railroad), frame, and math diagrams. Use whenever the user wants a quick terminal-native diagram — faster than HTML for ad-hoc visualizations.
license: MIT
metadata:
  author: pi
  version: "1.0.0"
  tool: diagon
  website: https://arthursonzogni.com/Diagon/
---

# TUI Visual Explainer — diagon

Generate beautiful ASCII/Unicode diagrams **directly in the terminal** using `diagon`. Designed for quick, ad-hoc visualizations of architectures, workflows, schemas, topologies, and concepts without leaving the terminal.

> **When to use this vs. visual-explainer (HTML):**
> - **tui-visual-explainer** → quick inline diagrams, terminal-only workflows, dependency graphs, flowcharts, sequence diagrams, tables, trees
> - **visual-explainer (HTML)** → complex presentations, slide decks, rich CSS layouts, Mermaid + Chart.js, shareable pages

## Installation

```bash
# Homebrew
brew install diagon

# Snap
sudo snap install diagon

# Cargo
cargo install diagon

# or download from https://github.com/ArthurSonzogni/Diagon/releases
```

## Usage

```
diagon <TRANSLATOR> [options] [-- <input> | < input_file]
```

- **Stdin:** `echo "input" | diagon Translator`
- **File:** `diagon Translator < file.txt`
- **Inline:** `diagon Translator -- "input text"`

## Translators

### 1. Flowchart — Flussdiagramme / Entscheidungsbäume

C-like if/else Syntax. Perfekt für Entscheidungsbäume, Prozessabläufe, Algorithmen.

**Syntax:**
```
"statement";                         // einfacher Knoten
if ("condition") "then_branch";      // if-Verzweigung
if ("condition") "then" else "else"; // if/else
if ("cond1")
  "branch_a";
else if ("cond2")
  "branch_b";
else
  "branch_c";
```

**Beispiel:**
```bash
echo 'if ("Is it working?")
  "Great!";
else
  "Debug it";' | diagon Flowchart
```
```
  ______________
 ╱              ╲    ┌──────┐
╱ Is it working? ╲___│Great!│
╲                ╱yes└──────┘
 ╲______________╱
        │no
   ┌────▽───┐
   │Debug it│
   └────────┘
```

### 2. Sequence — Sequenzdiagramme

`Actor -> Other: message` — Pfeile zwischen Akteuren. Ideal für APIs, Kommunikationsflüsse, Protokolle.

**Syntax:**
```
Actor1 -> Actor2: Message text     // Pfeil rechts
Actor1 <- Actor2: Response text    // Pfeil links
```

**Mit Nummerierung (Reihenfolge markieren):**
```
1) Actor1 -> Actor2: First message
2) Actor2 -> Actor3: Second message

Actor1: 1<2     // Nachricht 1 vor 2
Actor2: 2<1     // Nachricht 2 vor 1
```

**Beispiel:**
```bash
echo 'Client -> Server: GET /api/users
Client <- Server: 200 OK
Server -> Database: SELECT * FROM users
Server <- Database: [rows]' | diagon Sequence
```

### 3. Table — Tabellen

CSV-Input → formatierte Tabelle. Perfekt für Vergleiche, Audits, Metriken.

**Syntax:** Komma-separierte Werte pro Zeile.

**Styles:**
- `--style=unicode` (default)
- `--style=unicode double` — ╔ ╗ ║ ╚ ╝
- `--style=unicode with bold header` — ┏━┓ Kopfzeile, ┃ normale Zeilen
- `--style=unicode rounded` — abgerundete Ecken
- `--style=ascii` — pure ASCII
- `--style=ascii rounded` — ASCII mit `.`/`'` Ecken
- `--style=ascii light header` — dezente Kopfzeile
- `--style=conceptual` — minimalistisch

**Beispiel:**
```bash
echo 'Component,Status,Version
API Gateway,Healthy,2.1.0
Auth Service,Healthy,1.8.3
Payment Service,Degraded,3.0.1' | diagon Table --style="unicode double"
```
```
╔═════════════╦════════╦═════════╗
║Component    ║Status  ║Version  ║
╠═════════════╬════════╬═════════╣
║API Gateway  ║Healthy ║2.1.0    ║
╠═════════════╬════════╬═════════╣
║Auth Service ║Healthy ║1.8.3    ║
╠═════════════╬════════╬═════════╣
║Payment Srv  ║Degraded║3.0.1    ║
╚═════════════╩════════╩═════════╝
```

### 4. Tree — Baumstrukturen / Hierarchien

Einrückungs-basierte Bäume. Ideal für Dateisysteme, Organigramme, Klassenhierarchien.

**Syntax:** Einrückung mit Leerzeichen (2 Spaces pro Ebene).

**Styles:**
- `--style="unicode 1"` (default) — ├─ └─
- `--style="unicode 2"` — ├── └──
- `--style="ASCII 1"` — rein ASCII
- `--style="unicode right top"` — waagerecht rechts

**Beispiel:**
```bash
echo 'Project
  src
    components
      Header.tsx
      Footer.tsx
    pages
      Home.tsx
  public
    index.html
  package.json' | diagon Tree
```
```
Project
 ├─src
 │ ├─components
 │ │ ├─Header.tsx
 │ │ └─Footer.tsx
 │ └─pages
 │    └─Home.tsx
 ├─public
 │ └─index.html
 └─package.json
```

### 5. GraphDAG — Directed Acyclic Graphs

`A -> B` für Abhängigkeiten, Build-Graphen, Modul-Topologien.

**Syntax:** `source -> target` pro Zeile. Automatisches Layering.

**Beispiel:**
```bash
echo 'weblayer -> chrome
chrome -> content
chrome -> blink
content -> blink
content -> net
blink -> v8
blink -> base
net -> base' | diagon GraphDAG
```

Perfekt für: Build-Abhängigkeiten, Modul-Topologien, Datenfluss.

### 6. Grammar — Railroad-Diagramme

EBNF/ABNF Grammatiken → Syntax-Diagramme (Railroad).

**Syntax:**
```
rule = option1 | option2
rule = sequence part1 part2
rule = [optional] {repeated}
```

**Optionen:**
- `--input=abnf` (default), `bnf`, `iso-ebnf`, `rbnf`, `wsn`
- `--output=unicode` (default), `ascii`, `svg`, `html5`, etc.

### 7. Frame — Rahmen mit Zeilennummern

Text mit dekorativem Rahmen und optionalen Zeilennummern.

**Synopsis:**
```
diagon Frame [--ascii_only] [--line_number=true/false]
```

**Beispiel:**
```bash
cat code.cpp | diagon Frame
```
```
┌─┬────────────────────┐
│1│#include <iostream> │
│2│using namespace std;│
│3│int main() {        │
│4│  return 0;         │
│5│}                   │
└─┴────────────────────┘
```

### 8. Math — Mathematische Ausdrücke

Ascii-art Darstellung von Brüchen, Summen, Integralen, Matrizen.

**Styles:** `--style=Unicode` (default), `Ascii`, `Latex`

**Beispiel:**
```bash
echo "sum(i^2,i=0,n) = n^3/2+n^2/2+n/6" | diagon Math
```
```
n
___
╲    2    3    2
╱   i  = n /2+n /2+n/6
‾‾‾
i=0
```

## Cheatsheet — Schnellreferenz

| Translator | Input Format | Use Case |
|-----------|-------------|----------|
| `Flowchart` | C-like if/else | Entscheidungsbäume, Prozesse |
| `Sequence` | `A -> B: msg` | API-Calls, Kommunikation |
| `Table` | CSV | Vergleiche, Metriken, Audits |
| `Tree` | Einrückung | Hierarchien, Dateisysteme |
| `GraphDAG` | `A -> B` pro Zeile | Abhängigkeiten, Topologien |
| `Grammar` | EBNF/ABNF | Syntax-Diagramme |
| `Frame` | Plain text | Code-Blöcke, Zitate |
| `Math` | Math-Ausdrücke | Formeln, Berechnungen |

## Recipes — Kombos für häufige Szenarien

### Architektur-Übersicht (GraphDAG + Table)
```bash
# Topologie zeigen
echo "frontend -> api
api -> auth
api -> users
api -> payments" | diagon GraphDAG

# Metadaten als Tabelle
echo 'Service, Sprache, Port
auth, Go, 3001
users, Python, 3002
payments, Rust, 3003' | diagon Table
```

### Prozess mit Entscheidungen (Flowchart)
```bash
diagon Flowchart << 'EOF'
"Start: Request received";
if ("Valid API key?")
  "Authenticate";
else
  "Reject: 401";

if ("Rate limit OK?")
  "Process request";
else
  "Reject: 429";

"Send response";
EOF
```

### CI/CD Pipeline (Sequence)
```bash
diagon Sequence << 'EOF'
Dev -> GitHub: git push
GitHub -> Actions: trigger workflow
Actions -> Test: run tests
Actions -> Build: build image
Actions -> Deploy: deploy to prod
EOF
```

## Tips

- **Piping in chains:** `cat data.csv | diagon Table --style="unicode double" | pbcopy` (auf macOS)
- **Alignment:** Tabellen erwarten CSV — achte auf konsistente Spalten
- **Lange Flowcharts:** Bei vielen Verzweigungen wird das Diagramm breit — Terminal-Fenster groß genug machen
- **Kein Browser nötig:** Diagon arbeitet rein im Terminal, perfekt für SSH-Sessions und CI-Logs
- **Weiterverarbeiten:** Diagon-Output kann in Markdown-Dateien, `bat`, oder `glow` gepiped werden
