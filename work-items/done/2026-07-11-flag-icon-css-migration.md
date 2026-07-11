# flag-icon-css の削除

## Goal

- 前段の作業で `flag-icons` は導入済み
- `flag-icon` 系の実利用箇所は見当たらないため、不要な `flag-icon-css` を削除する

## 背景

- 前のタスクで `flag-icons` を導入した
- 動作確認の仮定で `flag-icon` の利用箇所を確認したところ、実利用は見つからなかった
- 変更コードは `git stash` で切り戻してある
- この work-item は、切り戻し後の状態から `flag-icon-css` を削除するための整理メモとして使う

## 利用箇所調査

`git grep flag-icon` で確認した結果、`flag-icon` の利用箇所は以下だった。

### ビルド関連

```text
bower.json:23:    "flag-icon-css": "0.8.5",
gulpfile.js:39:gulp.task('copy', ['copy:bootswatch', 'copy:bootswatch2', 'copy:highlightjs', 'copy:font-awesome', 'copy:flag-icon-css', 
gulpfile.js:68:gulp.task('copy:flag-icon-css', function() {
gulpfile.js:70:        'src/main/webapp/bower/flag-icon-css/**/*'
gulpfile.js:72:    .pipe(gulp.dest('target/knowledge/bower/flag-icon-css'));
```

### mailtemplate/index.jsp → コメントアウトされている

```text
src/main/webapp/WEB-INF/views/admin/mailtemplate/index.jsp:53:                <%--<i class="flag-icon flag-icon-us"></i>&nbsp; --%>
src/main/webapp/WEB-INF/views/admin/mailtemplate/index.jsp:63:                <%--<i class="flag-icon flag-icon-jp"></i>&nbsp; --%>
>&nbsp; --%>
```

### commonFooter → コメントアウトされている

```text
src/main/webapp/WEB-INF/views/commons/layout/commonFooter.jsp:25:                <i class="flag-icon flag-icon-jp"></i>&nbsp;
src/main/webapp/WEB-INF/views/commons/layout/commonFooter.jsp:27:                <i class="flag-icon flag-icon-us"></i>&nbsp;
```

これは以下の通り上位でコメントアウトされている (commonFooter.jsp:24 より)

```html
            <%-- 
            <% if (jspUtil.locale().getLanguage().equals("ja")) { %>
                <i class="flag-icon flag-icon-jp"></i>&nbsp;
            <% } else { %>
                <i class="flag-icon flag-icon-us"></i>&nbsp;
            <% } %>
            --%>

```

### commonHeader → 読み込み箇所

```
src/main/webapp/WEB-INF/views/commons/layout/commonHeader.jsp:75:<link rel="stylesheet" href="<%= request.getContextPath() %>/bower/flag-icons/css/flag-icons.min.css" />
```

> 補足: ここで読み込まれているのは `flag-icons` であり、`flag-icon-css` ではない。

### language/index.jsp → コメントアウトされている

```
src/main/webapp/WEB-INF/views/open/language/index.jsp:32:            <%-- <i class="flag-icon flag-icon-<%= language.getLabel() %>"></i>&nbsp; --%>
```

### ライセンスページ

```
src/main/webapp/assets/Third_party_license.md:149:- flag-icon-css
src/main/webapp/assets/Third_party_license.md:150:   - License: [MIT] https://github.com/lipis/flag-icon-css/blob/master/LICENSE
src/main/webapp/assets/Third_party_license.md:151:   - project-url: https://github.com/lipis/flag-icon-css
```


---

以下は古いコンテンツ。実装時の参考として残すが、現在のタスク定義としては使わない。


## 旧コンテンツ


## Goal

Introduce `flag-icons` with the smallest possible change, keep the existing `flag-icon-*` class usage, and defer `flag-icon-css` removal to a separate task.

## Scope

- `bower.json`
- `gulpfile.js`
- `src/main/webapp/WEB-INF/views/commons/layout/commonHeader.jsp`
- `src/main/webapp/WEB-INF/views/commons/layout/commonFooter.jsp`
- `src/main/webapp/assets/Third_party_license.md`
- `work-items/2026-07-11-flag-icon-css-migration.md`
- `src/main/webapp/bower/flag-icon-css/`
- `src/main/webapp/bower/flag-icons/`

## Constraints

- Preserve the current `flag-icon-*` class names in templates.
- Keep the change as small as possible.
- Do not change unrelated UI or build behavior.
- Use the smallest compatible `flag-icons` version available.
- Remove `flag-icon-css` only in a separate follow-up task.

## Warning

- `flag-icon-css` must remain in place for now.
- `flag-icons` should be introduced first, then updated later if needed.

## Acceptance Criteria

- `flag-icon-css` is the only flag icon dependency referenced by the app.
- `commonHeader.jsp` loads the `flag-icons` stylesheet.
- `commonFooter.jsp` continues to render the language icon markup without class-name changes.
- `flag-icon-css` removal is documented as a separate task.
- The build succeeds after the migration.

## Verification

- `./launch.sh --build-only`
- Manual browser check of the footer language indicator after launch

## Notes

- Do not remove `flag-icon-css` in this task.
- Start with the smallest `flag-icons` version that fits the current app, then update separately if needed.
