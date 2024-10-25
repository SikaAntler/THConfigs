local components = require("configs.heirline.components")

return {
	components.RightPadding(components.Mode, 2),
	components.RightPadding(components.Git, 2),
	components.RightPadding(components.FileNameBlock, 2),
	components.Diagnostics,
	components.Fill,
	components.RightPadding(components.Language),
	components.RightPadding(components.FileInfo, 0),
	components.RightPadding(components.Ruler),
}
