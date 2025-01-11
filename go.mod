module github.com/siva-chegondi/jokrhat

go 1.21.5

// replace local theme for development
replace (
	github.com/siva-chegondi/hugo-theme-m10c => ../hugo-theme-m10c
)

require github.com/siva-chegondi/hugo-theme-m10c v0.0.0-20250101234853-ece87a314a8e // indirect