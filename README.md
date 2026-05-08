# BC Journal Entry Bot

> **Production automation tool built for Associated Students, Inc. (ASI) at California State University, Long Beach.**  
> Reduces journal entry processing time by **70–95%** depending on entry complexity.

---

## What It Does

The BC Journal Entry Bot is a desktop application that reads **DocuSign journal entry PDFs** and **CashNet Excel files**, structures the data into debit/credit journal lines, and automatically enters them into **Microsoft Dynamics 365 Business Central** — with zero API integration required.

Previously, manually entering a multi-line journal entry required navigating Business Central field by field for each line. This bot parses the source document, validates the data, and executes the full keyboard-driven entry sequence automatically.

**It is live in production at ASI CSULB today.**

---

## Impact

| Metric | Before | After |
|---|---|---|
| Entry time (simple 2-line JE) | ~2 min | ~5 sec |
| Entry time (multi-line JE) | ~10–15 min | ~30–60 sec |
| Processing time reduction | — | **70–95%** |
| Manual keystrokes per entry | 100–300+ | ~3 (load, verify, ALT+F8) |

---

## Features

- **PDF Parsing** — Reads page 1 of DocuSign JE PDFs using layout-preserving extraction (`pdfplumber`, `PyMuPDF`). Handles simple 2-line transfers and multi-line entries with complex object code formats (`A5106-0`, `G70-8423-0`, `6440-7103-G60-5484-0`).
- **Excel Support** — Attaches CashNet XLSX detail files (`openpyxl`) when first-page data is insufficient. Positive = Debit, Negative/Parenthetical = Credit.
- **Live PDF Preview** — Renders page 1 of the loaded PDF directly in the UI using PyMuPDF.
- **Editable Journal Table** — Review, edit, add, delete, or swap debit/credit lines before entry.
- **Balance Validation** — Real-time ✓ BALANCED / Δ unbalanced indicator with debit/credit totals.
- **ALT+F8 Hotkey** — Start or stop Business Central entry from anywhere on the screen.
- **Immediate Entry** — No countdown, no confirmation prompt. Starts instantly.
- **Object Code Normalization** — Automatically cleans trailing zero variants (`-00` → `-0`, `-02` → `-2`).
- **Configurable Tab Offset** — Adjustable tabs after Object Code field to match Business Central layout.
- **CSV Export** — Export parsed lines to CSV for audit or review.
- **Activity Log** — Color-coded in-app log for every parse, entry, and error event.

---

## Tech Stack

| Layer | Tools |
|---|---|
| Language | Python 3.11+ |
| UI Framework | `customtkinter` (dark theme, Discord/Steam-inspired) |
| PDF Parsing | `pdfplumber`, `PyMuPDF (fitz)`, `pypdf` |
| Excel Parsing | `openpyxl` |
| UI Automation | `pyautogui`, `keyboard` |
| Clipboard | `pyperclip` |
| Image Rendering | `Pillow` |
| Target System | Microsoft Dynamics 365 Business Central |

---

## Business Central Entry Flow

For each parsed journal line, the bot executes this sequence automatically:

```
Account No. → [TAB] → Department Code → [TAB] → Description → [TAB]
→ Debit Amount → [TAB] → Credit Amount → [TAB] → Comment → [TAB]
→ Object Code → [TAB] × N (configurable)
```

---

## How to Run

**Requirements:** Python 3.11 or newer, Windows

```bash
# Clone the repo
git clone https://github.com/wasimahin/bc-journal-entry-bot.git
cd bc-journal-entry-bot

# Run the launcher (installs dependencies automatically)
run.bat
```

The launcher (`run.bat`) detects your Python installation, verifies version, auto-installs all required libraries via pip, and launches the app.

**Manual install:**
```bash
pip install customtkinter pdfplumber pyautogui pyperclip openpyxl pymupdf pillow pypdf keyboard
python je_bot.py
```

---

## Supported PDF Patterns

- Simple 2-line transfers (one debit, one credit)
- One balancing cash line + multiple detail lines
- Object codes: `A5106-0`, `G70-8423-0`, `A1234-2`
- Combined codes: `6440-7103-G60-5484-0`
- Posting month extracted from header (e.g., `APRIL 2025`)
- JE number extraction from document title or body

---

## Excel Rules (ATTACH XLSX mode)

When the PDF's first page is insufficient (indicated in the UI), attach the CashNet Excel detail file:

- **Positive amount** → Debit
- **Negative amount** or **parentheses** → Credit
- Object codes normalized on load

---

## Hotkeys

| Key | Action |
|---|---|
| `ALT+F8` | Start / Stop BC entry |

> For global hotkey support (works even when the app is not in focus), install the `keyboard` package and run with sufficient OS privileges.

---

## Troubleshooting

| Issue | Check |
|---|---|
| App doesn't open | `startup_error.log` |
| Parsing fails | `je_bot_errors.log` |
| PDF parses incorrectly | Use **ATTACH XLSX** or open an issue with the PDF layout |
| ALT+F8 not working | Install `keyboard` package; run as admin if needed |

---

## Project Context

Built independently as part of my role as **Lead Business Office Representative at ASI CSULB**, where I manage financial documentation for 500+ registered campus organizations. This tool is one of two production Python automation tools I engineered for the office — the other being the **Snehin Check Request Helper** ([repo link here](https://github.com/wasimahin/snehin-check-request-helper)).

Both tools run live with zero API integration, operating entirely through UI automation against Microsoft Dynamics 365 Business Central.

---

## Author

**Wasi Mahin**  
Dual-Major: Management Information Systems & Accountancy | CSULB  
[LinkedIn](https://linkedin.com/in/wasi-mahin) · [GitHub](https://github.com/wasimahin) · wasimahin@gmail.com
