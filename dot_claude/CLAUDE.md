# AI Coding Rules

- Respond in Japanese.
- Use sub-agents whenever possible.

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
