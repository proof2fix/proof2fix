note
	model: sequence

class
	ARRAYED_LIST_MERGE_RIGHT_1 [G]

create
	make, make_from_area

feature

	bugged (other: like Current; index: INTEGER)
		note
			explicit: wrapping
		require
			different_other: Current /= other
			area.is_wrapped and other.area.is_wrapped
			not_after: 0 <= index and index <= area.count
		local
			l_new_count: INTEGER
			count, other_count: INTEGER
		do
			count := area.count
			other_count := other.area.count
			l_new_count := count + other_count

			unwrap
			if l_new_count > count then
				area := area.aliased_resized_area_with_default2 (({G}).default, l_new_count)
			end
			area.move_data (index, index + other_count, count - index)
			area.copy_data (other.area, 0, index, other_count)

			sequence := area.sequence
			wrap

			other.wipe_out
		ensure
			modify (area)
			modify (Current)
			modify (other)
			modify (other.area)
			new_count: area.count = old area.count + old other.area.count
			other_is_empty: other.area.count = 0
		end

	fixed_1 (other: like Current; index: INTEGER)
		note
			explicit: wrapping
		require
			different_other: Current /= other
			area.is_wrapped and other.area.is_wrapped
			not_after: 0 <= index and index <= area.count
			different_areas: area /= other.area
		local
			l_new_count: INTEGER
			count, other_count: INTEGER
		do
			count := area.count
			other_count := other.area.count
			l_new_count := count + other_count

			unwrap
			if l_new_count > count then
				area := area.aliased_resized_area_with_default2 (({G}).default, l_new_count)
			end
			area.move_data (index, index + other_count, count - index)
			area.copy_data (other.area, 0, index, other_count)

			sequence := area.sequence
			wrap

			other.wipe_out
		ensure
			modify (area)
			modify (Current)
			modify (other)
			modify (other.area)
			new_count: area.count = old area.count + old other.area.count
			other_is_empty: other.area.count = 0
		end

	fixed_2 (other: like Current; index: INTEGER)
		note
			explicit: wrapping
		require
			different_other: Current /= other
			not_after: 0 <= index and index <= area.count

			current_owns: owns ~ create {MML_SET [ANY]}.singleton (area)
			other_owns: other.owns ~ create {MML_SET [ANY]}.singleton (other.area)
		local
			l_new_count: INTEGER
			count, other_count: INTEGER
		do
			count := area.count
			other_count := other.area.count
			l_new_count := count + other_count

			unwrap
			if l_new_count > count then
				area := area.aliased_resized_area_with_default2 (({G}).default, l_new_count)
			end
			area.move_data (index, index + other_count, count - index)
			area.copy_data (other.area, 0, index, other_count)

			sequence := area.sequence
			wrap

			other.wipe_out
		ensure
			modify (area)
			modify (Current)
			modify (other)
			modify (other.area)
			new_count: area.count = old area.count + old other.area.count
			other_is_empty: other.area.count = 0
		end

feature {NONE} -- Initialization

	make
			-- Create an empty list with default `capacity' and `growth_rate'.
		note
			status: creator
		do
			create area.make_empty (0)
		ensure
			area.count = 0
			area.capacity = 0
			sequence_empty: sequence.is_empty
		end

	make_from_area (a_area: like area)
		note
			status: creator
		do
			area := a_area
		ensure
			area = a_area
		end

feature

	sequence: MML_SEQUENCE [G]
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	area: V_SPECIAL2 [G]

	item (i: INTEGER): G
		require
			owns_def: owns = (create {MML_SET [ANY]}.singleton (area))
			i_not_too_small: i >= 1
			i_not_too_big: i <= area.count
			observers_open: ∀ o: observers ¦ o.is_open
		do
			Result := area.item (i - 1)
		ensure
			Result = sequence [i]
		end

	extend (v: G)
		note
			explicit: wrapping
		require -- from V_LIST
			observers_open: ∀ o: observers ¦ o.is_open
			owns.has (area)
		local
			new_area: like area
		do
			if area.count = area.capacity then
				unwrap
				area := area.aliased_resized_area_with_default (v, area.count + 1)
				sequence := sequence.extended (v)
				wrap
			else
				unwrap
				area.extend (v)
				sequence := sequence.extended (v)
				wrap
			end
		ensure
			modify_model (["sequence"], Current)
			area.count = old area.count + 1
			owns.has (area) implies sequence.item (area.count) = v
			sequence_appended: sequence ~ old sequence & v
		end

	wipe_out
		require
			(area.is_wrapped) or (owns.has (area))
			is_wrapped
		do
			area.wipe_out
			create sequence
		ensure
			modify_model (["sequence"], Current)
			modify (area)
			area.count = 0
			sequence.count = 0
			area.count = 0
			area.sequence.is_empty
			area = old area
		end

invariant
	owns.has (area) implies (attached area implies sequence ~ area.sequence)

end
