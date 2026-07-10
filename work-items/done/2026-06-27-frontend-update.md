# frontend update

## 本作業の目的

- bower.json に記載されたフロントエンドライブラリのアップデート

## 本作業のゴール

- 一律に上げることを目指さず、ユーザと対話しながら決定する

## 対象タスク

- `highlightjs` を `highlight.js` へ移行する
- 更新対象バージョンは npm の最新安定版 `11.11.1`

## 実施内容

- `bower.json` の `highlightjs` を `highlight.js` に置換し、Bower 参照先を GitHub の `highlight.js` リポジトリへ変更した
- `commonHeader.jsp` と `highlight.jsp` のテーマ参照を `highlight.js` の配布構成に合わせて更新した
- `darkula` / `far` / `kimbie.light` の表示崩れに対して、`pre code.hljs` のベーススタイルを補うように調整した
- `commonScripts.jsp` では `highlight.js` 11.11.1 の CDN 読み込みに切り替えた
- `initHighlightingOnLoad()` を `highlightAll()` に置換した
- `license` ページのコードブロック出力を `highlight.js` 11 系の表示に合わせて調整した

## 動作確認結果

- `./launch.sh --build-only` でビルド成功を確認した
- テーマ選択画面の `darkula` / `far` / `kimbie.light` の表示崩れを解消した
- `default` テーマは従来どおり表示できることを確認した
- `license` ページのコードハイライト表示も問題ないことを確認した

## 回収項目

- `bower.json` の依存名とバージョンの更新
- `highlight.pack.js` 参照の見直し
- `hljs.initHighlightingOnLoad()` の廃止対応
- テーマ CSS のパスと利用可否の確認
- `license` ページのコードハイライト処理の動作確認

## 影響範囲

- `src/main/webapp/WEB-INF/views/commons/layout/commonHeader.jsp`
- `src/main/webapp/WEB-INF/views/commons/layout/commonScripts.jsp`
- `src/main/webapp/WEB-INF/views/open/thema/highlight.jsp`
- `src/main/webapp/WEB-INF/views/open/license/index.jsp`
- `bower.json`

## 検証方針

- `./launch.sh --build-only` でビルド確認を行なう
- 起動後、コードブロック表示とテーマ表示を目視確認する
- `highlightAuto()` と `highlightAll()` の互換性差分を確認する
