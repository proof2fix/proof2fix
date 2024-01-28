class
	MAPLE_RECURSIVE_MAX_3_1

feature
	max (x, y, z: INTEGER): INTEGER
		do
			if x > y and x > z then
				Result := x + 2
				-- correction: Result := x
			else
				if y > z then
					Result := y
				else
					Result := z
				end
			end
		ensure
			max_x: x >= y and x >= z implies Result = x
			max_y: y >= x and y >= z implies Result = y
			max_z: z >= x and z >= y implies Result = z
		end

end
