theory Termination imports Main Import_everything begin

termination takebytes
  apply lexicographic_order
done

termination dropbytes
  apply(relation "measure (\<lambda>(l,_). l)")
  apply(auto simp add: naturalZero_def)
done

lemma dropbytes_length_inversion:
  assumes "dropbytes len bs0 = Success bs1"
  shows "len < length0 bs0"
sorry

lemma dropbytes_length:
  fixes len :: "nat" and bs bs1 :: "byte_sequence"
  assumes "0 < len" and "dropbytes len bs = Success bs1"
  shows "length0 bs1 < length0 bs" (is ?thesis)
using assms
sorry
  
termination list_take_with_accum
  apply lexicographic_order
done

lemma list_take_with_accum_length:
  fixes len :: "nat" and xs accum :: "'a list"
  assumes "len < length xs"
  shows "length (list_take_with_accum len accum xs) = len + length accum"
using assms proof(induction len arbitrary: accum xs)
  fix xs :: "'a list" and accum :: "'a list"
  assume "0 < length xs"
  thus "length (list_take_with_accum 0 accum xs) = 0 + length accum" by auto
next
  fix len :: "nat" and accum :: "'a list" and xs :: "'a list"
  assume IH: "(\<And>accum xs :: 'a list. len < length xs \<Longrightarrow> length (list_take_with_accum len accum xs) = len + length accum)"
    and *: "Suc len < length xs"
  show "length (list_take_with_accum (Suc len) accum xs) = Suc len + length accum"
  proof(cases xs)
    assume "xs = []"
    thus ?thesis using * by auto
  next
    fix y :: "'a" and ys :: "'a list"
    assume **: "xs = y#ys"
    hence ***: "len < length ys"
      using * by simp
    have "length (list_take_with_accum (Suc len) accum xs) = length (list_take_with_accum (Suc len) accum (y#ys))"
      using ** by auto
    moreover have "... = length (list_take_with_accum len (y#accum) ys)"
      by auto
    moreover have "... = len + length (y#accum)"
      using IH *** by simp
    ultimately show "length (list_take_with_accum (Suc len) accum xs) = Suc len + length accum"
      by auto
  qed
qed

lemma takebytes_r_with_length_inversion:
  assumes "takebytes_r_with_length cnt len bs0 = Success bs1"
  shows "len < length0 bs0"
sorry

lemma takebytes_r_with_length_length:
  assumes "takebytes_r_with_length cnt len bs0 = Success bs1"
  shows "length0 bs1 < length0 bs0"
using assms
  sorry

lemma takebytes_length:
  fixes len :: "nat" and bs bs1 :: "byte_sequence"
  assumes "takebytes len bs = Success bs1"
  shows "length0 bs1 = len"
using assms
sorry

lemma offset_and_cut_length:
  assumes "offset_and_cut off len bs0 = Success bs1"
  shows "length0 bs1 = len"
using assms unfolding offset_and_cut_def
  apply(case_tac "dropbytes off bs0", simp_all add: error_bind.simps)
  apply(case_tac "takebytes len x1", simp_all add: error_bind.simps error_return_def)
  apply(rule takebytes_length, assumption)
done

lemma partition_with_length_length:
  assumes "partition_with_length off len bs0 = Success (bs1, bs2)"
  shows "length0 bs1 = off \<and> length0 bs2 = len"
sorry

lemma read_archive_entry_header_length:
  assumes "read_archive_entry_header len bs = Success (hdr, sz, bs1)"
  shows "Byte_sequence.length0 bs1 < Byte_sequence.length0 bs"
using assms unfolding read_archive_entry_header_def
  sorry

lemma chooseAndSplit_card1:
  assumes "chooseAndSplit dict s = Some (x, y)"
  shows "card x < card s"
sorry

lemma chooseAndSplit_card2:
  assumes "chooseAndSplit dict s = Some (x, y, z)"
  shows "card z < card s"
using assms unfolding chooseAndSplit_def
  sorry

lemma lt_technical1:
  fixes q :: nat
  assumes "0 < q"
  shows "0 < 2 * q"
using assms by auto

lemma lt_technical2:
  fixes m :: nat
  shows "0 < Suc m"
by auto

lemma read_elf32_dyn_cong [fundef_cong]:
  assumes "endian0 = endian1" and "bs0 = bs1" and "shared_object0 = shared_object1" and "os_additional_ranges0 = os_additional_ranges1"
     and "os0 = os1" and "proc0 = proc1"
  shows "read_elf32_dyn endian0 bs0 shared_object0 os_additional_ranges0 os0 proc0 = read_elf32_dyn endian1 bs1 shared_object1 os_additional_ranges1 os1 proc1"
using assms by simp

lemma find_first_not_in_range_cong [fundef_cong]:
  assumes "start1 = start2" and "ranges1 = ranges2"
  shows "find_first_not_in_range start1 ranges1 = find_first_not_in_range start2 ranges2"
using assms by simp

lemma find_first_in_range_cong [fundef_cong]:
  assumes "start1 = start2" and "ranges1 = ranges2"
  shows "find_first_in_range start1 ranges1 = find_first_in_range start2 ranges2"
using assms by simp

section {* Termination *}

termination accum_archive_contents
  apply(relation "measure (\<lambda>(_,_,_,b). length0 b)")
  apply simp
  apply(case_tac x1, simp)
  apply(frule read_archive_entry_header_length)
  apply(case_tac "size0 a mod 2", simp add: Let_def)
  apply(case_tac "name a = ''/               ''", simp)
  apply(frule dropbytes_length, assumption)
  apply linarith
  apply(frule dropbytes_length, assumption)
  apply linarith
  apply simp
  apply(subgoal_tac "0 < Suc (size0 a)")
  apply(frule dropbytes_length, assumption)
  apply linarith
  apply auto
done

termination repeat
  apply(relation "measure (\<lambda>(l,_). l)")
  apply auto
done

termination concat_byte_sequence
  apply lexicographic_order
done

lemma read_elf32_sword_length:
  assumes "read_elf32_sword endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_elf32_word_length:
  assumes "read_elf32_word endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_elf32_addr_length:
  assumes "read_elf32_addr endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_4_bytes_be_length:
  assumes "read_4_bytes_be bs0 = Success (bytes, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_4_bytes_le_length:
  assumes "read_4_bytes_le bs0 = Success (bytes, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

termination obtain_elf32_dynamic_section_contents'
  apply(relation "measure (\<lambda>(_, b, _, _, _, _). length0 b)")
  apply simp+
  apply(case_tac bs0)
  apply simp
  apply(simp only: read_elf32_dyn_def Let_def)
  apply(case_tac "read_elf32_sword endian (Sequence xa)")
  apply(simp_all add: error_bind.simps)
  apply(case_tac x1, simp)
  apply(case_tac "tag_correspondence_of_tag shared_object (nat \<bar>sint a\<bar>) os_additional_ranges os proc", simp_all add: error_bind.simps)
  apply(case_tac x1a, simp_all)
  apply(case_tac "read_elf32_word endian b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(drule read_elf32_sword_length)
  apply(drule read_elf32_word_length)
  apply linarith
  apply(case_tac "read_elf32_addr endian b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(drule read_elf32_sword_length)
  apply(drule read_elf32_addr_length)
  apply linarith
  apply(case_tac endian, simp_all)
  apply(case_tac "read_4_bytes_be b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(case_tac aa, simp)
  apply(drule read_elf32_sword_length)
  apply(drule read_4_bytes_be_length)
  apply linarith
  apply(case_tac "read_4_bytes_le b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(case_tac aa, simp)
  apply(drule read_elf32_sword_length)
  apply(drule read_4_bytes_le_length)
  apply linarith
done

lemma read_elf64_xword_length:
  assumes "read_elf64_xword endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_elf64_sxword_length:
  assumes "read_elf64_sxword endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_elf64_addr_length:
  assumes "read_elf64_addr endian bs0 = Success (wrd, bs1)"
  shows "length0 bs1 < length0 bs0"
sorry

lemma read_8_bytes_be_length:
  assumes "read_8_bytes_be b = Success (bytes, bs0)"
  shows "length0 bs0 < length0 b"
sorry

lemma read_8_bytes_le_length:
  assumes "read_8_bytes_le b = Success (bytes, bs0)"
  shows "length0 bs0 < length0 b"
sorry

termination obtain_elf64_dynamic_section_contents'
  apply(relation "measure (\<lambda>(_, b, _, _, _, _). length0 b)")
  apply simp+
  apply(case_tac bs0)
  apply simp
  apply(simp only: read_elf64_dyn_def Let_def)
  apply(case_tac "read_elf64_sxword endian (Sequence xa)")
  apply(simp_all add: error_bind.simps)
  apply(case_tac x1, simp)
  apply(case_tac "tag_correspondence_of_tag shared_object (nat \<bar>sint a\<bar>) os_additional_ranges os proc", simp_all add: error_bind.simps)
  apply(case_tac x1a, simp_all)
  apply(case_tac "read_elf64_xword endian b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(drule read_elf64_xword_length)
  apply(drule read_elf64_sxword_length)
  apply linarith
  apply(case_tac "read_elf64_addr endian b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(drule read_elf64_sxword_length)
  apply(drule read_elf64_addr_length)
  apply linarith
  apply(case_tac endian, simp_all)
  apply(case_tac "read_8_bytes_be b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(case_tac aa, simp)
  apply(case_tac g, simp)
  apply(drule read_elf64_sxword_length)
  apply(drule read_8_bytes_be_length)
  apply linarith
  apply(case_tac "read_8_bytes_le b", simp_all add: error_bind.simps)
  apply(case_tac x1b, simp)
  apply(case_tac aa, simp)
  apply(case_tac g, simp)
  apply(drule read_elf64_sxword_length)
  apply(drule read_8_bytes_le_length)
  apply linarith
done

termination find_first_not_in_range
  sorry

termination find_first_in_range
  sorry

termination compute_differences
  apply(relation "measure (\<lambda>(s, m, _). m - s)")
  sorry

termination read_elf32_program_header_table'
  sorry

termination read_elf64_program_header_table'
  sorry

termination read_elf32_relocation_section'
  sorry

termination read_elf64_relocation_section'
  sorry

termination read_elf32_relocation_a_section'
  sorry

termination read_elf64_relocation_a_section'
  sorry

termination read_elf32_section_header_table'
  sorry

termination read_elf64_section_header_table'
  sorry

termination get_elf32_section_to_segment_mapping
  sorry

termination get_elf64_section_to_segment_mapping
  sorry

termination read_elf32_symbol_table
  sorry

termination read_elf64_symbol_table
  sorry

termination repeatM
  apply lexicographic_order
done

termination repeatM'
  apply lexicographic_order
done

termination mapM
  apply lexicographic_order
done

termination foldM
  apply lexicographic_order
done

termination group_elf32_words
  apply lexicographic_order
done

termination group_elf64_words
  apply lexicographic_order
done

termination read_gnu_ext_elf32_verdefs
  sorry

termination read_gnu_ext_elf64_verdefs
  sorry

termination obtain_gnu_ext_elf32_veraux
  sorry

termination obtain_gnu_ext_elf64_veraux
  sorry

termination read_gnu_ext_elf32_verneeds
  sorry

termination read_gnu_ext_elf64_verneeds
  sorry

termination read_gnu_ext_elf32_vernauxs
  sorry

termination obtain_gnu_ext_elf64_vernaux (* XXX: why the discrepancy with the function above? *)
  apply lexicographic_order
done

termination concatS'
  apply lexicographic_order
done

termination nat_range
  apply lexicographic_order
done

termination expand_sorted_ranges
  apply lexicographic_order
done

termination make_byte_pattern_revacc
  apply lexicographic_order
done

termination relax_byte_pattern_revacc
  apply lexicographic_order
done

termination byte_list_matches_pattern
  apply lexicographic_order
done

termination accum_pattern_possible_starts_in_one_byte_sequence
  apply lexicographic_order
done

termination natural_of_decimal_string_helper
  apply lexicographic_order
done

termination hex_string_of_natural
  apply lexicographic_order
done

termination merge_by
  apply lexicographic_order
done

termination mapMaybei'
  apply lexicographic_order
done

termination partitionii'
  apply lexicographic_order
done

termination intercalate'
  apply lexicographic_order
done

termination take
  apply lexicographic_order
done

termination string_index_of'
  apply lexicographic_order
done

termination find_index_helper
  apply lexicographic_order
done

termination replicate_revacc
  apply lexicographic_order
done

termination list_reverse_concat_map_helper
  apply lexicographic_order
done

termination findLowestEquiv
  apply(relation "measure (\<lambda>(_,_,_,_,_,s,_). Finite_Set.card s)")
  apply safe
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card2)
  apply simp
done

termination findHighestEquiv
  apply(relation "measure (\<lambda>(_,_,_,_,_,s,_). Finite_Set.card s)")
  apply safe
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card1)
  apply simp
  apply(frule chooseAndSplit_card2)
  apply simp
done

end