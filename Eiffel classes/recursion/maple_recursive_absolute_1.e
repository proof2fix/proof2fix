class
	MAPLE_RECURSIVE_ABSOLUTE_1

feature

	abs (x: INTEGER): INTEGER
		do
			if  x >= 2 then -- proof2fix: if x = 1 or x >= 2 then
				Result := x
			else
				Result := - x
			end
		ensure
			arg_when_arg_non_negative: x >= 0 implies Result = x
			negative_when_arg_negative: x < 0 implies Result = -x
		end

end
