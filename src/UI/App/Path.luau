local Path = {}
Path.__index = Path

export type Path = typeof(setmetatable({}, Path))

type multiInstance<MI1, MI2> = {
	Inst1: MI1,
	Inst2: MI2,
}

function Path.newInstance<PI>(Inst: PI): PI
	local self = setmetatable({}, Path)

	return self
end

function Path.newMultiInstance<MI1, MI2>(Inst1: MI1, Inst2: MI2): multiInstance<MI1, MI2>
	local self = setmetatable({}, Path)
	self.Instance1 = Inst1
	self.Instance2 = Inst2

	return self
end

function Path.getInstance<GI>(GetInstance: GI): GI
	return GetInstance
end

return Path
