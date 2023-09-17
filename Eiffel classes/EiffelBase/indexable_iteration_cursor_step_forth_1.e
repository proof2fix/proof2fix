note
	description: "Concrete version of an external iteration cursor for {INDEXABLE}."
	library: "EiffelBase: Library of reusable components for Eiffel."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	date: "$Date: 2013-03-22 04:46:02 -0700 (Fri, 22 Mar 2013) $"
	revision: "$Revision: 92328 $"

	model: first_index, target_index

class
	INDEXABLE_ITERATION_CURSOR_STEP_FORTH_1 [G]

create
	make

feature

	buggy
			-- Move to next position.
		require -- from ITERATION_CURSOR
			valid_position: not after
		do
			if is_reversed then
				target_index := target_index - step
			else
				target_index := target_index + step
			end
		ensure
			cursor_index_advanced: cursor_index_buggy = old cursor_index_buggy + 1
		end

	cursor_index_buggy: INTEGER_32
			-- Index position of cursor in the iteration.
		do
			Result := ((target_index - first_index).abs + step - 1) // step + 1
		ensure
			positive_index: Result >= 0
		end

	fixed
		note
			explicit: wrapping
		require
			valid_position: not after
		do
			if before then
				unwrap
				target_index := first_index
				wrap
			else
				if is_reversed then
					unwrap
					target_index := target_index - step
					wrap
				else
					unwrap
					target_index := target_index + step
					wrap
				end
			end

		ensure
			modify_model ("target_index", Current)
			cursor_index_advanced: cursor_index_fixed = old cursor_index_fixed + 1
		end

	before: BOOLEAN
		do
			if is_reversed then
				Result := target_index > first_index
			else
				Result := target_index < first_index
			end
		ensure
			is_reversed implies Result = (target_index > first_index)
			not is_reversed implies Result = (target_index < first_index)
		end

	cursor_index_fixed: INTEGER_32
			-- Index position of cursor in the iteration.
		note
			status: pure
		do
			if is_reversed then
				if target_index <= first_index then
					Result := (first_index - target_index + step - 1) // step + 1
				end
			else
				if target_index >= first_index then
					Result := (target_index - first_index + step - 1) // step + 1
				end
			end
		ensure
			positive_index: Result >= 0
			before_is_zero: before implies Result = 0
			reversed_in: is_reversed and target_index <= first_index implies Result = (first_index - target_index + step - 1) // step + 1
			not_reversed_in: not is_reversed and target_index >= first_index implies Result = (target_index - first_index + step - 1) // step + 1
		end

feature {NONE} -- Initialization

	make (s: like target)
			-- Initialize cursor using structure `s'.
		require
			s_attached: s /= Void
		do
			target := s
			step := 1
			is_reversed := False
		ensure
			structure_set: target = s
			default_step: step = 1
			ascending_traversal: not is_reversed
		end

feature -- Access

	decremented alias "-" (n: like step): like Current
			-- Copy of Current with step decreased by `n'.
		require
			n_valid: step > n
		do
			Result := twin
			Result.set_step (step - n)
		ensure
			is_incremented: Result.step = step - n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

	first_index: INTEGER_32

	incremented alias "+" (n: like step): like Current
			-- Copy of Current with step increased by `n'.
		require
			n_valid: step + n > 0
		do
			Result := twin
			Result.set_step (step + n)
		ensure
			is_incremented: Result.step = step + n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

	last_index: INTEGER_32
			-- First and last valid index of target for current iteration.
			-- Note that if is_reversed, first_index might be greater than last_index.

	reversed alias "-": like Current
			-- Reversed copy of Current.
		do
			Result := twin
			Result.reverse
		ensure
			is_reversed: Result.is_reversed = not is_reversed
			same_structure: Result.target = target
			same_step: Result.step = step
		end

	step: INTEGER_32
			-- Distance between successive iteration elements.

	target_index: INTEGER_32
			-- Index position of target for current iteration.

	with_step (n: like step): like Current
			-- Copy of Current with step set to `n'.
		require
			n_positive: n > 0
		do
			Result := twin
			Result.set_step (n)
		ensure
			step_set: Result.step = n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

feature -- Status report

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := not target.valid_index (target_index)
		ensure
			Result = not target.valid_index (target_index)
		end

	is_first: BOOLEAN
			-- Is cursor at first position?
		do
			Result := target_index = first_index
		end

	is_last: BOOLEAN
			-- Is cursor at last position?
		do
			Result := target_index = last_index
		end

	is_reversed: BOOLEAN
			-- Are we traversing target backwards?
feature -- Status setting

	reverse
			-- Flip traversal order.
		do
			is_reversed := not is_reversed
		ensure
			is_reversed: is_reversed = not old is_reversed
		end

	set_step (v: like step)
			-- Set increment step to `v'.
		require
			v_positive: v > 0
		do
			step := v
		ensure
			step_set: step = v
		end

	target: V_READABLE_INDEXABLE [G]
			-- Associated structure used for iteration.

invariant
	target_attached: target /= Void
	step_positive: step > 0
	first_greater_when_reversed: is_reversed implies first_index >= last_index
	last_greater_when_not_reversed: not is_reversed implies last_index >= first_index

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class INDEXABLE_ITERATION_CURSOR
