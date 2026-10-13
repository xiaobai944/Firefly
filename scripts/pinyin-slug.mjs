/**
 * 把中文标题转成拼音文件名（slug）。
 * 用法：node scripts/pinyin-slug.mjs "等我这两天有空"
 * 输出：deng-wo-zhe-liang-tian-you-kong
 */
import { pinyin } from "pinyin-pro";

const input = (process.argv[2] ?? "").trim();
if (!input) process.exit(1);

const parts = [];
let buf = "";
for (const ch of [...input]) {
	if (/[\u4e00-\u9fff]/.test(ch)) {
		if (buf) {
			parts.push(buf);
			buf = "";
		}
		parts.push(...pinyin(ch, { toneType: "none", type: "array" }));
	} else {
		buf += ch;
	}
}
if (buf) parts.push(buf);

const slug = parts
	.join("-")
	.toLowerCase()
	.replace(/[^a-z0-9-]/g, "")
	.replace(/-+/g, "-")
	.replace(/^-|-$/g, "");

if (!slug) process.exit(2);
process.stdout.write(slug);
