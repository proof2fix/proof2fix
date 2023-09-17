class
	LINKED_LIST_MAKE_NOT_BEFORE_1

create
	buggy, fixed

feature
	buggy
		do
			before := True
		ensure
			is_before: before
			before_constraint: before implies (active = first_element)
		end

	fixed
		do
			before := True
			active := first_element
		ensure
			is_before: before
			before implies (active = first_element)
		end

	before: BOOLEAN

	active, first_element: INTEGER

	forth
		do
			before := False
			active := active + 1
		end

-- invariant
--	before_constraint: true --before implies (active = first_element)

end
