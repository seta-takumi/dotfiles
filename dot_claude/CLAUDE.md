# AI Coding Rules

- Respond in Japanese.
- Use sub-agents whenever possible.

## advisor ツールの扱い

- advisor はメイン会話（親エージェント）専用。サブエージェント（Agent/Task）には
  tool 定義が渡らないため、内部で呼ぼうとすると「Advisor unavailable」になる。
- サブエージェントを起動するときは、プロンプトに「advisor は呼ばない」と明示する。
- 強いレビュー・相談が必要な作業は、サブエージェントには結論と根拠だけ返させ、
  親会話に戻ってから advisor を呼ぶ。

## セッション名（Claude デスクトップアプリ）

- Issue / PR を扱うセッションの名前は `#番号 【フェーズ】 中身` の形にする。
  例: `#864 【調査】 Twitter の日付を UTC+9 の JST 日付で出す`、
  `#864 【実装】 Twitter の日付を UTC+9 の JST 日付で出す`、
  `#845 【修正方針】 kintone から消えた行を当月スナップショットから消す`、
  `PR #876 【レビュー】 ARRAY型カラムの修正`
- 【フェーズ】は 調査・修正方針・実装・レビュー・手順レビュー・報告 など、そのセッションでやる段階。
  同じ Issue の別フェーズのセッションと並べたとき、どれがどの段階か一目で分かるようにする。
- 中身は `gh issue view` / `gh pr view` のタイトルから短くまとめる。同じ Issue なら中身はそろえる。
- 「調査」「PR影響の確認」「方針の再検討」のような作業の種類だけの名前にしない。
  何を・どこを調べるか、どの PR の何への影響かまで入れる。
  例: `調査` → `Twitter AD 粒度で列が取り違わる原因の調査`、
  `PR影響の確認` → `PR #877 の外部テーブル分割が日次 Workflow に与える影響の確認`
- 番号だけ・種類だけの名前になっていたら、最初の返答までに `set_session_title` で付け直す。
  中身がまだ分からなければ、分かった時点で付け直す。

## Git Commit Message Format

**必須**: Conventional Commitsフォーマットを使用
**任意**: gitmoji （許可されたリポジトリのみで使用）

```
<type>[optional scope]: <emoji> <description>

[optional body]
```

**Type と Emoji の対応**:

- feat: ✨ (新機能、機能改善)
- fix: 🐛 (バグ修正)
- docs: 📝 (ドキュメント)
- style: 💄 (フォーマット、コードスタイル)
- refactor: ♻️ (リファクタリング)
- perf: ⚡️ (パフォーマンス改善)
- test: ✅ (テスト)
- build: 👷 (ビルドシステム)
- ci: 🎡 (CI/CD)
- chore: 🔧 (その他、設定ファイルなど)

**例**:

- `feat: ✨ gitleaksによるシークレットスキャンを追加`
- `fix: 🐛 rumdlの警告を解消`
- `ci: 🎡 actions/checkoutをv6.0.1に更新`

## 参考

- [Conventional Commits](https://www.conventionalcommits.org/ja/v1.0.0/)
