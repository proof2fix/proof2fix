class
	LINKED_LIST_MAKE_AFTER_1

create
	buggy, fixed

feature
	buggy
		do
			before := True
		ensure
			is_before: before
			not_both: not (after and before)
		end

	fixed
		do
			before := True
			after := False
		ensure
			is_before: before
			-- not_is_after: not after
			not_both: not (after and before)
		end

	before, after: BOOLEAN

-- invariant
--	not_both_0: true --not (after and before)

end
