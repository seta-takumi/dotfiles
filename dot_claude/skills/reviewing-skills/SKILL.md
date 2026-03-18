---
name: reviewing-skills
description: Claude CodeのSKILL.mdファイルをAnthropicの公式ベストプラクティスに基づいてレビューします。スキルの品質チェック、構造の検証、改善提案を行います。「このスキルをレビューして」「SKILL.mdを確認して」「スキルを改善したい」「スキル品質チェック」などのリクエストで積極的に使用してください。スキルの作成・修正・レビュー依頼があれば必ずこのスキルを使ってください。
---

# スキルレビュー

Anthropic公式ベストプラクティスに基づいてSKILL.mdをレビューし、具体的な改善提案を行う。

## レビューワークフロー

### ステップ1: 対象スキルの特定

- ユーザーがパスを直接指定した場合はそれを使う
- 指定がなければカレントディレクトリでSKILL.mdを検索
- 複数存在する場合はユーザーに確認

### ステップ2: 読み込みと分析

1. SKILL.mdを完全に読み込む
2. バンドルされているファイル構造も確認（`ls`で）
3. [references/best-practice.md](references/best-practice.md) でチェックリスト全項目を確認
4. 以下の観点で分析する

### ステップ3: 多角的評価

**フロントマター**（[references/best-practice.md](references/best-practice.md) §1参照）
- `name`: 形式・長さ・命名規則
- `description`: 完全性・第三者記述・トリガー語・具体性

**コンテンツの質**（[references/best-practice.md](references/best-practice.md) §2-3参照）
- 簡潔さ: Claudeが既に知ることを繰り返していないか
- 自由度キャリブレーション: タスクの脆弱性に合った指示レベルか
- 専門知識の質: 汎用アドバイスか、具体的なドメイン知識か
- Why説明: 理由なしのMUST/NEVER多用はないか

**構造とパターン**（[references/best-practice.md](references/best-practice.md) §4-5参照）
- Progressive Disclosure: 詳細は別ファイルに、参照は1階層のみ
- Gotchasセクション: 非自明な落とし穴のリスト
- テンプレート・例: 入出力例や出力フォーマットの提示
- ワークフロー: チェックリスト形式、バリデーションループ

**アンチパターン**（[references/best-practice.md](references/best-practice.md) §6参照）
- 選択肢の多提示（デフォルトなし）
- Windowsスタイルのパス
- 時間依存情報
- マジック定数

### ステップ4: レビューレポート生成

```
# スキルレビューレポート: {skill-name}

## サマリー
- 総合評価: PASS | NEEDS_IMPROVEMENT | CRITICAL_ISSUES
- Critical: {件数} / Warning: {件数} / Info: {件数}

## Critical（必須修正）
{問題と修正例}

## Warning（推奨修正）
{問題と推奨例}

## Info（改善提案）
{オプションの強化案}

## 具体的な推奨事項
{修正前→修正後の例を含む具体的なアクション}
```

### ステップ5: インタラクティブな改善

レポート提示後：
1. 修正を希望するか確認
2. Critical問題を優先し、段階的に適用
3. 各修正後に再検証

## レビュー観点の優先順位

1. **description品質**（最重要）— スキルがトリガーされるかを左右する
2. **簡潔さ** — コンテキストウィンドウの無駄使いを防ぐ
3. **自由度キャリブレーション** — 適切な指示レベルか
4. **Progressive Disclosure** — 500行以下か、参照構造は適切か
5. **専門知識の質** — 具体的で実用的か
