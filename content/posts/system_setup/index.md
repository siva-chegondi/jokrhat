---
title: "Arch System - Pikachu Theme"
description: "Updated system config to update yabar menu and termite colors"
publishDate: "2019-05-08"
date: "2019-05-08"
keywords: "Arch, Theme"
---

**Good Looking system always encourages us to do best.** Recently, When I am checking out instagram I came across a post with mint distro screen with awesome look.
Then I decided to change my system look So I checked out different dot files and came up with using nord-termite project. So I used same color combination by copying the [config file](https://github.com/arcticicestudio/nord-termite/blob/develop/src/config).

{{<figure class="image-holder" src="/images/colortest.png" alt="colortest image">}}

Now its time for us to focus on yabar (menu), I rewrote the config and colors in order to change it, following is my config file   
**`.config/yabar/yabar.conf`**

{{<highlight config>}}
bar-list: ["bottom-bar"];
bottom-bar: {
	position: "bottom"
	font: "Droid Sans, FontAwesome Bold 10";
	background-color-rgb: 0xff2e3440;
	background-color-nowindow-argb: 0xff2e3440;
	slack-size: 0;
	underline-size: 0;
	gap-horizontal: 100;
	gap-vertical: 5;
	height: 35;

	block-list: ["workspace-block", "title-block", "band-width", "ram-size", "cpu-data", "date-block", "battery-block"];
	
	workspace-block: {
		exec: "YABAR_WORKSPACE";
		align: "left";
		internal-option1: "        ";
		foreground-color-rgb: 0xffffffff;
		underline-color-rgb: 0xffffffff;
		fixed-size: 50;
	};

	band-width: {
		exec: "YABAR_BANDWIDTH";
		internal-option1: "default";
		internal-option2: "    ";
		align: "right";
	        fixed-size: 80;
		foreground-color-rgb: 0xffffff;
		background-color-rgb: 0x228877;
	};

	cpu-data: {
        	exec: "YABAR_CPU";
	        interval: 5;
        	internal-prefix: " ";
	        internal-suffix: "%";
        	internal-space: true;
	        align: "left";
        	background-color-rgb: 0xff8800;
	        foreground-color-rgb: 0xffffff;
	};

	ram-size: {
        	exec: "YABAR_MEMORY";
	        interval: 10;
		align: "left";
	        internal-prefix: " "
        	background-color-rgb: 0xff782343;
	        foreground-color-rgb: 0xffffffff;
        	fixed-size: 75;
	};

	title-block: {
		# exec: "YABAR_TITLE";
		exec: "pwd"
		align: "left";
		variable-size: true;
		foreground-color-rgb: 0xffffffff;
		background-color-rgb: 0xff10c8c0;
	};

	date-block: {
		exec: "YABAR_DATE";
		internal-option1: "%a %d %b, %I:%M:%S";
		internal-prefix: "	"
		interval: 1;
		align: "right";
		fixed-size: 175;
		background-color-rgb:0xff234568;
	        foreground-color-rgb:0xffffffff;
	};

	battery-block: {
		exec: "YABAR_BATTERY";
	        internal-option1: "BAT0";
        	internal-option2: "				";
	        internal-suffix:  "%";
        	background-color-rgb:0xffc82727;
	        foreground-color-rgb:0xffffffff;
        	align: "right";
	        type: "periodic";
        	interval: 20;
	};	
	
}
{{</highlight>}}
Now you may wonder why I named this theme as Pikachu, ofcourse I am fan of it and added background image ;) I am using **`papercolor`** vim-airline theme to be compatible for nord colors.

{{<figure class="image-holder" src="/images/desktop.png" alt="Pikachu Desktop">}}
{{<figure class="image-holder" src="/images/vim.png" alt="Vim theme">}}

