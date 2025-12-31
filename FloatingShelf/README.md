# FloatingShelf ☁️

**The shelf your Mac has been missing.**

FloatingShelf is a lightweight, menu bar utility that transforms how you manage files on macOS. It gives you a temporary "shelf" to hold files while you navigate between apps, spaces, and folders.

**🚀 Designed to start fast and stay out of your way.**  
FloatingShelf lives in your menu bar and keeps your Dock clean. No clutter, just efficiency.

<!-- 
## Demo

![FloatingShelf Demo](assets/demo.gif)
-->

---

## Why FloatingShelf?

- **🖱 Frictionless Drag & Drop**: Drag files to the shelf, switch apps, and drop them where they need to go. No more awkward window juggling.
- **🧹 Keep Your Desktop Clean**: Stop using your Desktop as a temporary dumping ground. Use a shelf instead.
- **👻 Unobtrusive Design**: The window floats on top when you need it and tucks away when you don't. It's a menu bar app, so it won't clutter your Dock.
- **⚡️ Power User Friendly**: Control everything with keyboard shortcuts. `⌘W` to close, `⌘N` for new shelf, `Space` to preview.

---

## Key Features

### 📂 Smart Shelf
- **Auto-Naming**: The shelf automatically names itself based on the first file you drop.
- **Persistent Storage**: Restart your Mac without worry. Your files are saved safely.
- **Auto-Expand**: Drops open the shelf instantly so you can see your files.

### ⚡️ Quick Actions
- **AirDrop ✈️**: Share files to nearby devices with a single click.
- **ZIP Archiving 📦**: Bundle multiple files into a ZIP archive instantly.
- **Copy & Paste**: Copy files from the shelf to your clipboard to paste anywhere.
- **Sort ↕️**: Keep things organized by Name or Date.

### 🎨 Customizable
- **Color Coding**: Assign colors to shelves to organize by project or priority.
- **Action Bar**: Toggle buttons in Settings to show only the tools you use.
- **Language**: Choose between English and 日本語.
- **Launch at Login**: Ready to go the moment you start your day.

### ⌨️ Keyboard Shortcuts
| Shortcut | Action |
|:---|:---|
| `⌘N` | New Shelf |
| `⌘W` | Close Window |
| `⌘,` | Open Settings |
| `⌘Q` | Quit |
| `⌘A` | Select All |
| `Space` | Quick Look |
| `⌫` | Delete Selected |
| `↵` | Open Selected |

---

## Installation

### 📲 Pre-built App (Recommended)
1. Download `FloatingShelf.app` from the **[Releases](https://github.com/Factbact/FloatingShelf/releases)** page.
2. Drag it to your `/Applications` folder.
3. **Right-click** the app and select **Open**.

> **⚠️ Important Note Regarding Security Warning**
> To keep this app completely free and open-source, I have not registered for the Apple Developer Program ($99/year). Consequently, you may see a warning stating "Developer cannot be verified" on first launch. This is expected behavior.
>
> *   **Safety**: All source code is openly available in this repository for verification.
> *   **How to Open**: **Right-click** the app and select **"Open"**, then click **"Open"** again in the dialog. (This is only required once).

### 🛠 From Source
1. Clone the repository.
2. Open `FloatingShelf.xcodeproj` in Xcode (requires Xcode 14+).
3. Build and Run (`⌘+R`).

---

## How to Use

| Goal | Action |
|:---|:---|
| **Create a Shelf** | Click the menu bar icon ☁️ → "New Shelf" (or `⌥⌘Space`) |
| **Add Files** | Drag files onto the shelf window or the menu bar icon |
| **Move Files Out** | Drag files from the shelf to any other app (Finder, Mail, Slack, etc.) |
| **Preview** | Select a file and press `Space` |
| **Action** | Use the buttons at the bottom for Actions like ZIP, Copy, or Delete |
| **Close** | `⌘W` or click the red ✕ button |

> **💡 Note**: FloatingShelf is a "Menu Bar App". It does not appear in your Dock. Access preferences and new shelves from the ☁️ icon in your top menu bar.

---

## Requirements

- macOS 12.0 (Monterey) or later
- Apple Silicon or Intel Mac

---

## Changelog

### v1.9.0 (2024-12-31)
- 🌐 **Language Selection**: English / 日本語 in Settings
- ⌨️ **Keyboard Shortcuts**: Cmd+W (close), Cmd+N (new), Cmd+, (settings), Cmd+Q (quit)
- 🐛 **Fixed Settings Window**: Settings now displays correctly

### v1.8.0 (2024-12-31)
- 🐛 **Bug Fix**: Fixed drag & drop bug
- ✨ **Customizable Action Bar**, Sort, Launch at Login

---

## License

MIT License

---

# FloatingShelf（日本語） ☁️

**Macに足りなかった、「一時置き場」という革命。**

FloatingShelfは、ファイル移動のストレスをゼロにするmacOS用ユーティリティです。アプリやフォルダ間を行き来する際、ファイルを一時的に置いておける「棚（シェルフ）」を提供します。

**🚀 メニューバー常駐型で、邪魔になりません。**  
Dockを占有することなく、必要な時だけサッと使えます。

---

## なぜ FloatingShelf なのか？

- **🖱 ドラッグ＆ドロップが快適に**: ファイルを持って、アプリを切り替えて、ドロップ。ウィンドウを並べて無理やりドラッグする必要はもうありません。
- **🧹 デスクトップをきれいに**: 「とりあえずデスクトップに保存」はやめましょう。シェルフに置けば、デスクトップは常に整理整頓されたまま。
- **👻 邪魔にならないデザイン**: メニューバー常駐アプリなのでDockに表示されず、作業スペースを圧迫しません。
- **⚡️ パワーユーザー機能**: キーボードショートカットに完全対応。`⌘W`で閉じる、`⌘N`で新規、`Space`でプレビュー。

---

## 主な機能

### 📂 スマートなシェルフ
- **自動ネーミング**: 最初にドロップしたファイル名から、シェルフの名前を自動でつけます。
- **安心の自動保存**: Macを再起動してもファイルは消えません。
- **自動展開**: ファイルをドロップするとシェルフが自動で広がり、中身が見やすくなります。

### ⚡️ クイックアクション
- **AirDrop ✈️**: ワンクリックで近くのデバイスにファイルを送信。
- **ZIP 圧縮 📦**: 複数のファイルをその場でZIPにまとめられます。
- **コピー＆ペースト**: クリップボードにコピーして、他のアプリにペースト可能。
- **並べ替え ↕️**: 名前順・日付順でサッと整理。

### 🎨 自分好みにカスタマイズ
- **カラータグ**: プロジェクトや優先度に合わせてシェルフの色を変更可能（10色）。
- **アクションバー設定**: 頻繁に使うボタンだけを表示するように設定できます。
- **言語設定**: English / 日本語 を切り替え可能。
- **ログイン時起動**: Macを起動したらすぐに使い始められます。

### ⌨️ キーボードショートカット
| ショートカット | 操作 |
|:---|:---|
| `⌘N` | 新規シェルフ |
| `⌘W` | ウィンドウを閉じる |
| `⌘,` | 設定を開く |
| `⌘Q` | 終了 |
| `⌘A` | 全選択 |
| `Space` | クイックルック |
| `⌫` | 削除 |
| `↵` | 開く |

---

## インストール方法

### 📲 アプリをダウンロード（推奨）
1. **[Releases](https://github.com/Factbact/FloatingShelf/releases)** ページから `FloatingShelf.app` をダウンロードします。
2. `/Applications`（アプリケーション）フォルダに移動します。
3. アプリを**右クリック**して「開く」を選択します。

> **⚠️ インストール時の注意（セキュリティ警告について）**
> 本アプリは、完全に無料かつオープンソースで提供し続けるため、Appleの有料開発者プログラム（年間$99）には登録していません。 そのため、初回起動時に「開発元を検証できません」という警告が表示されますが、これは仕様です。
>
> *   **安全性について**: ソースコードは全てこのリポジトリで公開されています。不審なコードが含まれていないことは、コードを確認いただくことで保証しています。
> *   **起動方法**: アプリを**右クリック**して「開く」を選択し、表示されるダイアログで再度**「開く」**をクリックしてください（初回のみ）。

### 🛠 ソースコードから
1. リポジトリをクローンします。
2. Xcode (v14以上) で `FloatingShelf.xcodeproj` を開きます。
3. `⌘+R` でビルドして実行します。

---

## 使い方ガイド

| 目的 | 操作方法 |
|:---|:---|
| **シェルフを作る** | メニューバーの ☁️ アイコン → "New Shelf" (またはホットキー `⌥⌘Space`) |
| **ファイルを置く** | シェルフウィンドウ、またはメニューバーアイコンにドラッグ |
| **取り出す** | シェルフからFinder、メール、Slackなどへドラッグ |
| **プレビュー** | ファイルを選択して `Space` キー |
| **アクション** | 下部のボタンを使って、ZIP圧縮や削除などの操作が可能 |
| **閉じる** | `⌘W` または赤い ✕ ボタンをクリック |

> **💡 ヒント**: FloatingShelfは「メニューバー常駐アプリ」です。起動してもDockにはアイコンが表示されません。設定や新規作成は、画面右上のメニューバーにある ☁️ アイコンから行います。

---

## 動作環境

- macOS 12.0 (Monterey) 以降
- Apple Silicon または Intel Mac

---

## 更新履歴

### v1.9.0 (2024-12-31)
- 🌐 **言語選択**: 設定でEnglish / 日本語を切り替え可能
- ⌨️ **キーボードショートカット**: Cmd+W/N/,/Q に対応
- 🐛 **設定ウィンドウ修正**: 正常に表示されるように

### v1.8.0 (2024-12-31)
- 🐛 **バグ修正**: ドラッグ＆ドロップの不具合を修正
- ✨ **アクションバーカスタマイズ**、並べ替え、ログイン時起動

---

## License

MIT License
