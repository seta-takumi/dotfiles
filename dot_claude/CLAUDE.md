# AI Coding Rules

- Respond in Japanese.
- Use sub-agents whenever possible.

## advisor ツールの扱い

- advisor はメイン会話（親エージェント）専用。サブエージェント（Agent/Task）には
  tool 定義が渡らないため、内部で呼ぼうとすると「Advisor unavailable」になる。
- サブエージェントを起動するときは、プロンプトに「advisor は呼ばない」と明示する。
- 強いレビュー・相談が必要な作業は、サブエージェントには結論と根拠だけ返させ、
  親会話に戻ってから advisor を呼ぶ。

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
