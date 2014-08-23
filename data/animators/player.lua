return {
	default = "run",

	states = {
		["idle"] = { image = "idle.png", fw = 20, fh = 20, delay = 0.15 },
		["run"] = { image = "run.png", fw = 20, fh = 20, delay = 0.12 },
		["swing"] = { image = "swing.png", fw = 20, fh = 20, delay = 0.1 },
		["jump"] = { image = "jump.png", fw = 20, fh = 20, delay = 0.1 },
		["fly"] = { image = "fly.png", fw = 20, fh = 20, delay = 0.1 },
		["land"] = { image = "land.png", fw = 20, fh = 20, delay = 0.08 },
	},

	properties = {
		-- 0: idle
		-- 1: run
		-- 2: fly
		["state"] = { value = 0 },
		["swing"] = { value = false, isTrigger = true },
		["jump"] = { value = false, isTrigger = true },
	},

	transitions = {
		{
			from = "idle", to = "run",
			property = "state", value = 1
		},
		{
			from = "run", to = "idle",
			property = "state", value = 0
		},
		{
			from = "any", to = "swing",
			property = "swing", value = true
		},
		{
			from = "swing", to = "idle",
			property = "_finished", value = true
		},
		{
			from = "any", to = "jump",
			property = "jump", value = true
		},
		{
			from = "jump", to = "fly",
			property = "_finished", value = true
		},
		{
			from = "run", to = "fly",
			property = "state", value = 2
		},
		{
			from = "fly", to = "land",
			property = "state", value = 0
		},
		{
			from = "fly", to = "land",
			property = "state", value = 1
		},
		{
			from = "land", to = "idle",
			property = "_finished", value = true
		},
	}
}
