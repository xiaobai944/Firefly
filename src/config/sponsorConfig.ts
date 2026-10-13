import type { SponsorConfig } from "../types/sponsorConfig";

// 打赏功能当前已整体停用（见 siteConfig.ts 里 pages.sponsor = false）：
// 页面入口已从导航移除、/sponsor/ 返回 404、文章底部的打赏按钮也已关闭。
//
// 想重新开通打赏时：
//   1. 把你的收款码图片放进 public/assets/images/sponsor/
//   2. 在下面的 methods 里按注释格式加一条，enabled 设为 true
//   3. 把 siteConfig.ts 里的 pages.sponsor 改回 true

export const sponsorConfig: SponsorConfig = {
	// 页面标题，如果留空则使用 i18n 中的翻译
	title: "",

	// 页面描述文本，如果留空则使用 i18n 中的翻译
	description: "",

	// 打赏用途说明（已清空）
	usage: "",

	// 是否显示打赏者列表（已关闭）
	showSponsorsList: false,

	// 是否显示评论区，需要先在commentConfig.ts启用评论系统（已关闭）
	showComment: false,

	// 是否在文章详情页底部显示打赏按钮（已关闭）
	showButtonInPost: false,

	// 打赏方式列表（已清空）
	// 加回来的格式示例：
	// {
	// 	name: "支付宝",
	// 	icon: "fa7-brands:alipay",
	// 	qrCode: "/assets/images/sponsor/alipay.png",
	// 	link: "",
	// 	description: "使用 支付宝 扫码打赏",
	// 	enabled: true,
	// },
	methods: [],

	// 打赏者列表（可选，已清空）
	sponsors: [],
};
