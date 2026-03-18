# Skill Best Practices チェックリスト

## 目次
- [1. Frontmatter (YAML)](#1-frontmatter-yaml)
- [2. コンテンツの質と簡潔さ](#2-コンテンツの質と簡潔さ)
- [3. 自由度のキャリブレーション](#3-自由度のキャリブレーション)
- [4. 構造とパターン](#4-構造とパターン)
- [5. スクリプト品質（スクリプトがある場合）](#5-スクリプト品質スクリプトがある場合)
- [6. アンチパターン](#6-アンチパターン)
- [7. 重大度分類](#7-重大度分類)

---

## 1. Frontmatter (YAML)

### name

- [ ] 64文字以内
- [ ] 小文字、数字、ハイフンのみ使用
- [ ] 動名詞形（-ing）推奨（例: `processing-pdfs`, `analyzing-spreadsheets`）
- [ ] 曖昧な名前を避ける（`helper`, `utils`, `tools`, `documents`, `data`はNG）
- [ ] 予約語を含まない（`anthropic`, `claude`はNG）

### description

- [ ] 1024文字以内、空でない
- [ ] **第三者記述**（「I can help」「You can use this」ではなく「Processes files」）
- [ ] スキルが**何をするか**を明示
- [ ] スキルを**いつ使うべきか**を明示（具体的なトリガーワード・シナリオ）
- [ ] ファイル形式、タスクタイプ、キーワードを含む
- [ ] undertrigger防止のために「〜があれば必ずこのスキルを使って」のような積極的な記述
- [ ] XMLタグを含まない

**良い例:**
```yaml
description: Extracts text and tables from PDF files, fills forms, merges documents.
  Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
  Make sure to use this skill whenever PDFs are involved, even if not explicitly mentioned.
```

**悪い例:**
```yaml
description: Helps with documents  # 曖昧すぎる
description: I can process your PDF files  # 一人称はNG
```

---

## 2. コンテンツの質と簡潔さ

### 簡潔さの原則

- [ ] SKILL.mdボディが500行以下
- [ ] Claudeが既に知っている一般知識を繰り返していない
  - NG例: 「PDFはPortable Document Formatで...」
  - OK例: いきなり「pdfplumberを使って抽出する」
- [ ] 各情報にトークンコストを正当化できる価値がある
- [ ] 冗長な説明より具体的な例を優先している

**自問チェック:** 「Claudeはこの説明なしに間違えるか？」NOなら削除候補。

### 専門知識の質

- [ ] 汎用アドバイス（「エラーを適切に処理する」）ではなく具体的な内容
- [ ] ドメイン固有の知識を含む（特定のAPI、スキーマ、エッジケース）
- [ ] プロジェクト固有の規約・制約が含まれている
- [ ] エージェントが実際に直面するGotchas（落とし穴）がある

**良い専門知識の例:**
```markdown
## Gotchas

- `users`テーブルは論理削除を使用。`WHERE deleted_at IS NULL`が必須
- ユーザーIDはDBでは`user_id`、認証では`uid`、請求では`accountId`（すべて同じ値）
- `/health`は DBダウンでも200を返す。サービス全体確認は`/ready`を使う
```

**悪い例（汎用的すぎる）:**
```markdown
## エラー処理
エラーが発生した場合は適切に処理してください。
```

### Why説明

- [ ] ルールに理由が付いている（「なぜこうするか」が分かる）
- [ ] MUST/NEVER/ALWAYS の多用を避け、理由で説得している
- [ ] エージェントが文脈に応じて判断できるよう設計されている

**良い例（理由付き）:**
```markdown
テスト用アカウントを除外してください。テストデータが混入すると
売上レポートの数字が実際より10-15%高く見えることがあります。
```

**悪い例（理由なし）:**
```markdown
ALWAYS exclude test accounts. NEVER include test data.
```

---

## 3. 自由度のキャリブレーション

タスクの脆弱性・一貫性要件に合わせて指示レベルを設定する。

### 高い自由度（テキストベースの指示）

適切な場合:
- 複数のアプローチが有効
- 文脈に応じた判断が必要
- ヒューリスティックでの対応が有効

チェック:
- [ ] 選択肢の幅を確保しつつ方向性を示している
- [ ] 「何をするか」よりも「どう考えるか」を教えている

### 中程度の自由度（パラメータ付きテンプレート）

適切な場合:
- 推奨パターンがあるが変形可能
- 設定によって動作が変わる

チェック:
- [ ] デフォルト値が明示されている
- [ ] カスタマイズポイントが明確

### 低い自由度（具体的なスクリプト・手順）

適切な場合:
- 操作がエラーを起こしやすい
- 一貫性が重要
- 特定の順序が必要

チェック:
- [ ] 手順が明確で変更不可の部分が明示
- [ ] 「このコマンドを変更しないこと」等の明示がある

### キャリブレーション評価

- [ ] 脆弱なタスクに高い自由度を与えていない
- [ ] 柔軟なタスクに過度な制約を課していない
- [ ] 同一スキル内で部分ごとに適切なキャリブレーションがされている

**手順 vs. 宣言チェック:**
- [ ] 「何を出力すべきか」（宣言）ではなく「どうアプローチするか」（手順）を教えている
- [ ] 特定の例だけでなく同種の問題に汎用的に使える

---

## 4. 構造とパターン

### Progressive Disclosure

- [ ] SKILL.mdボディが核心的な指示のみ（500行/5000トークン以下が目標）
- [ ] 詳細な参照ファイルは`references/`等に分離
- [ ] 参照ファイルへのリンクが**1階層のみ**（SKILL.md → file.md、それ以上のネストはNG）
- [ ] **いつ**参照ファイルを読むべきか明示（「APIが非200を返したら`references/api-errors.md`を読む」）
- [ ] 100行以上の参照ファイルには目次がある

**良いリンク例:**
```markdown
**APIエラー処理**: APIが非200を返したら [references/api-errors.md](references/api-errors.md) を参照
**スキーマ定義**: テーブル構造は [references/schema.md](references/schema.md) を参照
```

**悪いリンク例:**
```markdown
詳細はreferences/を参照してください  # いつ読むかが不明
```

### Gotchasセクション

- [ ] 自明でない落とし穴のリストがある
- [ ] 一般的なアドバイスではなく具体的な誤りの訂正
- [ ] SKILL.mdの本文に含まれている（別ファイルでも可だが、エージェントが気づくこと）

### テンプレートと例

- [ ] 出力形式にはテンプレートを提供（prose説明より具体的構造が有効）
- [ ] 入出力ペアの例がある
- [ ] 厳格要件には`ALWAYS use this exact template`、柔軟タスクには`adapting as needed`
- [ ] 例が具体的で抽象的でない

### ワークフロー

- [ ] 複雑な操作はチェックリスト形式のステップに分解
- [ ] バリデーションループがある（実行→検証→修正→繰り返し）
- [ ] 条件分岐が明確（「〜の場合は〜ワークフロー」）
- [ ] Plan-validate-execute パターン（バッチ・破壊的操作に）

---

## 5. スクリプト品質（スクリプトがある場合）

### エラー処理

- [ ] エラー条件を明示的に処理している（Claudeに丸投げしていない）
- [ ] `FileNotFoundError`等の具体的な例外処理
- [ ] エラーメッセージが問題特定に役立つ具体的な内容

**良い例:**
```python
except FileNotFoundError:
    print(f"Field 'signature_date' not found. Available fields: {list(fields.keys())}")
```

### 定数の説明

- [ ] マジックナンバーに説明コメントがある
- [ ] タイムアウト値、リトライ回数等に根拠がある

**悪い例:** `TIMEOUT = 47  # なぜ47?`
**良い例:** `TIMEOUT = 30  # HTTPリクエストは通常30秒以内に完了するため`

### ファイルパス

- [ ] フォワードスラッシュのみ（`scripts/helper.py`）
- [ ] Windowsスタイルなし（`scripts\helper.py`はNG）
- [ ] ファイル名が内容を示す説明的な名前（`doc2.md`ではなく`form_validation_rules.md`）

### 依存関係

- [ ] 必要なパッケージがSKILL.mdに明示
- [ ] プラットフォーム制限が記載（claude.ai: npm/PyPI可、Claude API: ネットワーク不可）
- [ ] インストール手順が明確（`pip install pypdf`等）

### 実行 vs. 参照の明示

- [ ] 「実行する」か「参照として読む」かが明示されている
- [ ] `Run scripts/analyze.py` または `See scripts/analyze.py for the algorithm`

### MCP Tools

- [ ] 完全修飾ツール名を使用（`ServerName:tool_name`形式）
- [ ] `BigQuery:bigquery_schema`のようにサーバープレフィックスあり

---

## 6. アンチパターン

以下が**存在しないこと**を確認：

- [ ] デフォルトなしで複数の選択肢を並列提示
  - NG: 「pypdf, pdfplumber, PyMuPDF, pdf2imageが使えます」
  - OK: 「pdfplumberを使う。OCRが必要な場合はpdf2imageを使う」
- [ ] Windowsスタイルのパス（`scripts\helper.py`）
- [ ] 時間依存情報（「2025年8月以前は旧APIを使う」等）
- [ ] 説明なしのマジック定数
- [ ] 2階層以上のネストしたファイル参照
- [ ] パッケージがプリインストール済みと仮定
- [ ] 汎用的すぎる指示（「エラーを適切に処理する」）
- [ ] 特定タスクにしか使えない宣言的指示（手順を教えずに出力を指定）

---

## 7. 重大度分類

### Critical（必須修正）

- `description`が空、または何をするか/いつ使うかが不明
- SKILL.mdボディが500行を大幅に超過
- スクリプトにエラー処理がない（破壊的操作の場合）
- セキュリティ上の問題（機密情報の露出等）
- `name`が形式要件を満たしていない（予約語、大文字等）

### Warning（推奨修正）

- descriptionが第三者記述でない
- Progressive Disclosureが適用されていない（詳細がSKILL.mdに詰め込まれている）
- Gotchasセクションがない（複雑なドメインスキルの場合）
- 例や入出力ペアが不足
- 自由度が適切にキャリブレーションされていない
- MUST/NEVER多用、理由説明なし
- 参照ファイルのリンクに「いつ読むか」の説明がない

### Info（改善提案）

- 汎用知識の説明を削除できる
- より簡潔にできる箇所がある
- 追加の例があると良い
- 手順を手順 vs. 宣言的観点で改善できる
- テンプレートの活用で出力品質を向上できる
