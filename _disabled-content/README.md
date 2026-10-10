# 被停用的示例内容

这个目录用来存放**暂时不想显示在博客上、但又不希望删除**的内容。

## 为什么这里放的是「动态」而不是设置 `draft: true`

`posts`（文章）和 `projects`（项目）两个内容集合的 schema 里都有 `draft` 字段，
所以那些示例内容是通过在 frontmatter 里写 `draft: true` 来隐藏的——文件仍在原处，
本地运行 `pnpm dev` 时依然可见，方便随时查阅。

但 `dynamic`（动态）集合的 schema 只有 `published`、`pinned`、`location` 三个字段，
**没有 `draft`**；而且 `src/pages/api/dynamic.json.ts` 取出动态时没有任何过滤条件。
也就是说，在动态条目的 frontmatter 里写 `draft: true` 会被静默忽略，内容照样显示。

所以这里改用「把文件移出集合目录」的方式隐藏：`dynamic` 集合的加载路径是
`src/content/dynamic/`（见 `src/content.config.ts`），文件一旦不在这个目录里，
就不会被加载，自然也不会显示。文件名和内容都保持原样，没有做任何修改。

## 如何恢复

把 `dynamic/` 里的文件移回 `src/content/dynamic/` 即可：

```powershell
git -C E:\my_blog\Firefly mv _disabled-content/dynamic/*.md src/content/dynamic/
```

或者直接用文件资源管理器把文件拖回去。

## 当前内容

`dynamic/` 下的 4 个文件是 Firefly 主题自带的动态示例（发布于 2026-07-15），
并非你自己的内容。
