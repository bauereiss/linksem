chapter {* Generated by Lem from elf_memory_image_of_elf64_file.lem. *}

theory "Elf_memory_image_of_elf64_file" 

imports 
 	 Main
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_set" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_function" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_assert_extra" 
	 "Show" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_sorting" 
	 "Missing_pervasives" 
	 "Error" 
	 "Byte_sequence" 
	 "Endianness" 
	 "Elf_types_native_uint" 
	 "Default_printing" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_tuple" 
	 "Elf_header" 
	 "String_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_map" 
	 "Elf_program_header_table" 
	 "Elf_section_header_table" 
	 "Elf_interpreted_section" 
	 "Elf_interpreted_segment" 
	 "Elf_symbol_table" 
	 "Elf_file" 
	 "Elf_relocation" 
	 "Memory_image" 
	 "Memory_image_orderings" 
	 "Elf_memory_image" 

begin 

(*open import Basic_classes*)
(*open import Function*)
(*open import String*)
(*open import Tuple*)
(*open import Bool*)
(*open import List*)
(*open import Sorting*)
(*open import Map*)
(*import Set*)
(*open import Num*)
(*open import Maybe*)
(*open import Assert_extra*)

(*open import Byte_sequence*)
(*open import Default_printing*)
(*open import Error*)
(*open import Missing_pervasives*)
(*open import Show*)
(*open import Endianness*)

(*open import Elf_header*)
(*open import Elf_file*)
(*open import Elf_interpreted_section*)
(*open import Elf_interpreted_segment*)
(*open import Elf_section_header_table*)
(*open import Elf_program_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)
(*open import Elf_relocation*)
(*open import String_table*)

(*open import Memory_image*)
(*open import Memory_image_orderings*)

(*open import Elf_memory_image*)

(*val section_name_is_unique : string -> elf64_file -> bool*)
definition section_name_is_unique  :: " string \<Rightarrow> elf64_file \<Rightarrow> bool "  where 
     " section_name_is_unique name1 f = (
    (case  mapMaybe (\<lambda> sec .  
        if name1 =(elf64_section_name_as_string   sec) then Some sec else None
    )(elf64_file_interpreted_sections   f)
    of
        [_] => True
        | _ => False
    ))"


(*val create_unique_name_for_section_from_index : natural -> elf64_interpreted_section -> elf64_file -> string*)
definition create_unique_name_for_section_from_index  :: " nat \<Rightarrow> elf64_interpreted_section \<Rightarrow> elf64_file \<Rightarrow> string "  where 
     " create_unique_name_for_section_from_index idx1 s f = (
    (let secname1 = ((elf64_section_name_as_string   s))
    in if section_name_is_unique secname1 f then secname1 else gensym secname1))"


(*val create_unique_name_for_common_symbol_from_linkable_name : string -> elf64_symbol_table_entry -> string -> elf64_file -> string*)
definition create_unique_name_for_common_symbol_from_linkable_name  :: " string \<Rightarrow> elf64_symbol_table_entry \<Rightarrow> string \<Rightarrow> elf64_file \<Rightarrow> string "  where 
     " create_unique_name_for_common_symbol_from_linkable_name fname1 syment symname f = ( 
    (* FIXME: uniqueness? I suppose file names are unique. How to avoid overlapping with 
     * section names? *)
    fname1 @ ((''_'') @ symname))"

    
(*val get_unique_name_for_common_symbol_from_linkable_name : string -> elf64_symbol_table_entry -> string -> string*)
definition get_unique_name_for_common_symbol_from_linkable_name  :: " string \<Rightarrow> elf64_symbol_table_entry \<Rightarrow> string \<Rightarrow> string "  where 
     " get_unique_name_for_common_symbol_from_linkable_name fname1 syment symname = ( 
    (* FIXME: uniqueness? I suppose file names are unique. How to avoid overlapping with 
     * section names? *)
    fname1 @ ((''_'') @ symname))"


(*val elf_memory_image_of_elf64_file : forall 'abifeature. abi 'abifeature -> string -> elf64_file -> elf_memory_image*)
definition elf_memory_image_of_elf64_file  :: " 'abifeature abi \<Rightarrow> string \<Rightarrow> elf64_file \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image "  where 
     " elf_memory_image_of_elf64_file a fname1 f = ( 
    (* Do we have program headers? This decides whether we choose a 
     * sectionwise or segmentwise view. *)
    (case (elf64_file_program_header_table   f) of
        [] =>   (let extracted_symbols =  (extract_definitions_from_symtab_of_type sht_symtab f)
                in
                (let interpreted_sections_without_null = ((case (elf64_file_interpreted_sections   f) of
                    [] => failwith (''impossible: empty list of interpreted sections'')
                    | null_entry # more1 => more1
                ))
                in
                (let section_names_and_elements = (mapMaybei (\<lambda> i .  (\<lambda> isec1 .  
                    (* In principle, we can have unnamed sections. But 
                     * don't add the dummy initial SHT entry. This is *not* in the 
                     * list of interpreted sections. *)
                    if elf64_interpreted_section_equal isec1 null_elf64_interpreted_section then
                        (if i =( 0 :: nat) then None else failwith (''internal error: null interpreted section not at index 0''))
                    else 
                        if i =( 0 :: nat) then failwith (''internal error: non-null interpreted section at index 0'')
                        else
                        (let created_name = (create_unique_name_for_section_from_index i isec1 f)
                        in
                        (*let _ = errln (In file  ^ fname ^  created element name  ^ created_name ^  for section idx  ^ (show i) ^ , name  ^ 
                            isec.elf64_section_name_as_string)
                        in*)
                        Some (created_name, (|
                        startpos = None
                      , length1 = (Some(elf64_section_size   isec1))
                      , contents = (byte_pattern_of_byte_sequence(elf64_section_body   isec1))
                    |)))
                ))(elf64_file_interpreted_sections   f))
                in
                (let common_symbols = (List.filter (\<lambda> x .  unat ((elf64_st_shndx  (def_syment   x))) = shn_common) extracted_symbols)
                in
                (*let _ = Missing_pervasives.errln (Found  ^ (show (length common_symbols)) ^  common symbols in file  ^ fname)
                in*)
                (let common_symbol_names_and_elements = (mapMaybei (\<lambda> i .  (\<lambda> isym .  
                    (let symlen = (unat(elf64_st_size  (def_syment   isym)))
                    in
                    Some (get_unique_name_for_common_symbol_from_linkable_name fname1(def_syment   isym)(def_symname   isym), (|
                        startpos = None
                      , length1 = (Some symlen)
                      , contents = (List.replicate symlen None)
                    |)))
                )) common_symbols)
                in
                (let all_names_and_elements = (section_names_and_elements @ common_symbol_names_and_elements)
                in
                (* -- annotations are reloc sites, symbol defs, ELF sections/segments/headers, PLT/GOT/...
                 * Since we stripped the null SHT entry, mapMaybei would ideally index from one. We add one.  *)
                (let (elf_sections :: ( element_range option * elf_range_tag) list) = (mapMaybei (\<lambda> secidx_minus_one .  (
                    (\<lambda> (isec1, (secname1, _)) .  
                        (let (r ::  element_range option) = (Some(secname1, (( 0 :: nat),(elf64_section_size   isec1))))
                        in
                        Some (r, FileFeature(ElfSection((secidx_minus_one +( 1 :: nat)), isec1))))
                    )))
                    (List.zip interpreted_sections_without_null section_names_and_elements))
                in
                (let (symbol_defs :: ( element_range option * elf_range_tag) list) = (mapMaybe
                    (\<lambda> x .  
                        (let section_num = (unat(elf64_st_shndx  (def_syment   x)))
                        in
                        (let labelled_range =                            
 (if section_num = shn_abs then
                                (* We have an annotation that doesn't apply to any range.
                                 * That's all right -- that's why the range is a maybe. *)
                                None
                            else if section_num = shn_common then 
                                (* Each common symbol becomes its own elemenet (approx section).
                                 * We label *that element* with a (coextensive) symbol definition. *)
                                 (let element_name = (get_unique_name_for_common_symbol_from_linkable_name 
                                    fname1(def_syment   x)(def_symname   x))
                                 in
                                 Some(element_name, (( 0 :: nat), unat(elf64_st_size  (def_syment   x)))))
                            else 
                                (let (section_name, _) = ((case  Elf_Types_Local.index section_names_and_elements (section_num -( 1 :: nat)) of
                                    Some x => x
                                    | None => failwith ((''symbol '') @ ((def_symname   x) @ ('' references nonexistent section'')))
                                ))
                                in
                                Some(section_name, (unat(elf64_st_value  (def_syment   x)), unat(elf64_st_size  (def_syment   x))))))
                        in
                        Some (labelled_range, SymbolDef(x))))
                    )
                    (extract_definitions_from_symtab_of_type sht_symtab f))
                in
                (* FIXME: should a common symbol be a reference too? 
                 * I prefer to think of common symbols as mergeable sections. 
                 * Under this interpretation, there's no need for a reference. 
                 * BUT the GC behaviour might be different! What happens if
                 * a common symbol is not referenced? *)
                (let (symbol_refs :: ( element_range option * elf_range_tag) list) = (mapMaybe
                    (\<lambda> (x :: symbol_reference) .  
                        Some (None, SymbolRef((| ref = x, maybe_reloc = None, maybe_def_bound_to = None |)))
                    )
                    (extract_references_from_symtab_of_type sht_symtab f))
                in
                (let (all_reloc_sites :: (element_range * elf_range_tag) list) = (List.map 
                    (\<lambda> (x :: symbol_reference_and_reloc_site) . 
                        (let rel = ((case (maybe_reloc   x) of 
                            Some rel => rel
                            | None => failwith (''impossible: reloc site has no reloc'')
                        ))
                        in
                        (let (section_name, _) = ((case  Elf_Types_Local.index section_names_and_elements ((ref_src_scn   rel) -( 1 :: nat)) of
                            Some y => y
                            | None => failwith (''relocs came from nonexistent section'')
                        ))
                        in
                        (let (_, applyfn) = ((reloc   a) (get_elf64_relocation_a_type(ref_relent   rel)))
                        in
                        (let (width, calcfn) = (applyfn (get_empty_memory_image () )(( 0 :: nat)) x)
                         (* GAH. We don't have an image. 
                            If we pass an empty memory image, will we fail? Need to make it work *)
                        in
                          (* FIXME: for copy relocs, the size depends on the *definition*.
                             AHA! a copy reloc always *has* a symbol definition locally; it just gets its *value*
                             from the shared object's definition.
                             In other words, a copy reloc always references a defined symbol, and the amount
                             copied is the minimum of that symbol's size and the overridden (copied-from .so)'s 
                             symbol's size. *)
                        (let (offset :: Elf_Types_Local.uint64) = ((elf64_ra_offset  (ref_relent   rel)))
                        in 
                        ((section_name, (unat offset, width)), SymbolRef(x)))))))
                    )
                    (extract_all_relocs_as_symbol_references fname1 f))
                in
                (let all_reloc_pairs = (List.map (\<lambda> (el_range, r_tag) .  (Some el_range, r_tag)) all_reloc_sites)
                in
                (let reloc_as_triple = (\<lambda> ((_ :: bool Memory_image.range_tag), (x :: bool Memory_image.range_tag)) .  ((case  x of
                            SymbolRef(r) => (case (maybe_reloc   r) of
                                Some rel => ((ref_rel_scn   rel),(ref_rel_idx   rel),(ref_src_scn   rel))
                                | None => failwith (''impossible: '')
                                )
                            | _ => failwith (''unexpected tag'')
                        )))
                in
                (*let _ = Missing_pervasives.errln (Extracted  ^ (show (length all_reloc_sites)) ^  reloc site tags from 
                    ^ file  ^ fname ^ :  ^ (show (List.map reloc_as_triple all_reloc_sites)))
                in*)
                (let retrieved_reloc_sites = (Multimap.lookupBy0 
  (instance_Basic_classes_Ord_Memory_image_range_tag_dict
     Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict) (instance_Basic_classes_Ord_tup2_dict
   Lem_string_extra.instance_Basic_classes_Ord_string_dict
   (instance_Basic_classes_Ord_tup2_dict
      instance_Basic_classes_Ord_Num_natural_dict
      instance_Basic_classes_Ord_Num_natural_dict))  (Memory_image_orderings.tagEquiv
    Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict)
                    (SymbolRef(null_symbol_reference_and_reloc_site)) 
                    ((let ((fst1 :: (string * Memory_image.range) list), (snd :: ( Abis.any_abi_feature Memory_image.range_tag) list)) = (list_unzip all_reloc_sites) in List.set (List.zip snd fst1))))
                in
                (*let _ = Missing_pervasives.errln (Re-reading: retrieved  ^ (show (length retrieved_reloc_sites)) ^  reloc site tags from 
                    ^ file  ^ fname ^ :  ^ (show (List.map reloc_as_triple (let (fst, snd) = unzip retrieved_reloc_sites in zip snd fst))))
                in*)
                (let elf_header = ([(Some((''header''), (( 0 :: nat), unat(elf64_ehsize  (elf64_file_header   f)))), FileFeature(ElfHeader((elf64_file_header   f))))])
                in
                (*let _ = Missing_pervasives.errln (ELF header contributes  ^ (show (List.length elf_header)) ^  annotations.)
                in*)
                (let all_annotations_list = ((((all_reloc_pairs @ symbol_refs) @ symbol_defs) @ elf_sections) @ elf_header)
                in
                (let all_annotations_length = (List.length all_annotations_list)
                in
                (*let _ = Missing_pervasives.errln (total annotations:  ^ (show all_annotations_length))
                in*)
                (let all_annotations = (List.set all_annotations_list)
                in
                (let (apply_content_relocations :: string \<Rightarrow> byte_pattern \<Rightarrow> byte_pattern) = (\<lambda> (name1 :: string) .  (\<lambda> content .  
                    (let this_element_reloc_sites = (List.filter (\<lambda> ((n, range), _) .  name1 = n) all_reloc_sites)
                    in
                    (let ((this_element_name_and_reloc_ranges :: (string * (nat * nat)) list), _) = (list_unzip this_element_reloc_sites)
                    in
                    (let (this_element_reloc_ranges :: (nat * nat) list) = (snd (list_unzip this_element_name_and_reloc_ranges))
                    in
                    (let (all_ranges_expanded :: bool list) = (expand_unsorted_ranges this_element_reloc_ranges (List.length content) [])
                    in
                    relax_byte_pattern content all_ranges_expanded))))
                ))
                in
                (let new_elements_list = (List.map (\<lambda> (name1, element) .  
                    (* We can now mark the relocation sites in the section contents as subject to change. *)
                    (
                        name1, 
                        (|
                           startpos = ((startpos   element))
                         , length1   = ((length1   element))
                         , contents =                            
( 
                            (*let _ = errln (Reloc-relaxing section  ^ name ^  in file  ^ fname ^ : before, first 20 bytes:  ^
                                (show (take 20 element.contents)))
                            in*)(let relaxed = (apply_content_relocations name1(contents   element))
                            in
                            (*let _ = errln (After, first 20 bytes:  ^  (show (take 20 relaxed)))
                            in*)
                            relaxed))

                         |)
                    )
                  ) all_names_and_elements)
                in
                            (*
                            List.foldr (fun acc -> (fun  element.contents this_element_reloc_ranges
                            let (expand_and_relax : list (maybe byte) -> (natural * natural) -> list (maybe byte)) = fun pat -> (fun r -> (
                                relax_byte_pattern pat (expand_ranges r)
                            ))
                            in*)
                 (|
                      elements = (Map.map_of (List.rev new_elements_list))
                      (* : memory_image -- the image elements, without annotation, i.e. 
                        a map from string to (startpos, length, contents)
                        -- an element is the ELF header, PHT, SHT, section or segment
                        -- exploit the fact that section names beginning `.' are reserved, and 
                           the reserved ones don't use caps: .PHT, .SHT, .HDR
                        -- what about ambiguous section names? use .GENSYM_<...> perhaps 
                      *)
                    , by_range = all_annotations
                    , by_tag = ((let (fst1, snd) = (list_unzip all_annotations_list) in List.set (List.zip snd fst1)))
                        (*  : multimap (elf_range_tag 'symdef 'reloc 'filefeature 'abifeature) (string * range) 
                         -- annotations by *)
                  |))))))))))))))))))))
      | pht => (let segment_names_and_images = (mapMaybei (\<lambda> i .  (\<lambda> seg .  
                    Some((gensym (hex_string_of_natural(elf64_segment_base   seg)) @ ((''_'') @ (hex_string_of_natural(elf64_segment_type   seg)))), 
                    (|
                        startpos = (Some(elf64_segment_base   seg))
                      , length1 = (Some(elf64_segment_memsz   seg))
                      , contents = ([]) (* FIXME *)
                     |))
                ))(elf64_file_interpreted_segments   f))
                in
                (* let annotations = *)
                 (|
                      elements = (Map.map_of (List.rev segment_names_and_images))  (* : memory_image -- the image elements, without annotation, i.e. 
                        a map from string to (startpos, length, contents)
                        -- an element is the ELF header, PHT, SHT, section or segment
                        -- exploit the fact that section names beginning `.' are reserved, and 
                           the reserved ones don't use caps: .PHT, .SHT, .HDR
                        -- what about ambiguous section names? use .GENSYM_<...> perhaps 
                      *)
                    , by_range = (List.set [])
                        (* : map element_range (list (elf_range_tag 'symdef 'reloc 'filefeature 'abifeature))
                         -- annotations are reloc sites, symbol defs, ELF sections/segments/headers, PLT/GOT/...  *)
                    , by_tag = (List.set [])
                        (*  : multimap (elf_range_tag 'symdef 'reloc 'filefeature 'abifeature) (string * range) 
                         -- annotations by *)
                  |))

    ))"


(*val elf_memory_image_header : elf_memory_image -> elf64_header*)
definition elf_memory_image_header  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow> elf64_header "  where 
     " elf_memory_image_header img3 = ( 
    (case  unique_tag_matching 
  Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict (FileFeature(ElfHeader(null_elf_header))) img3 of
        FileFeature(ElfHeader(x)) => x
        | _ => failwith (''impossible: no header'')
    ))"


(*val elf_memory_image_sht : elf_memory_image -> maybe elf64_section_header_table*)
definition elf_memory_image_sht  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>((elf64_section_header_table_entry)list)option "  where 
     " elf_memory_image_sht img3 = ( 
    (case  unique_tag_matching 
  Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict (FileFeature(null_section_header_table)) img3 of
        FileFeature(ElfSectionHeaderTable(x)) => Some x
        | _ => None
    ))"


(*val elf_memory_image_section_ranges : elf_memory_image -> (list elf_range_tag * list element_range)*)
definition elf_memory_image_section_ranges  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>((Abis.any_abi_feature)range_tag)list*(element_range)list "  where 
     " elf_memory_image_section_ranges img3 = ( 
    (* find all element ranges labelled as ELF sections *)
    (let tagged_ranges = (tagged_ranges_matching_tag 
  Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict (FileFeature(ElfSection(( 0 :: nat), null_elf64_interpreted_section))) img3)
    in
    (let (tags, maybe_ranges) = (list_unzip tagged_ranges)
    in
    (tags, make_ranges_definite maybe_ranges))))"


(*val elf_memory_image_section_by_index : natural -> elf_memory_image -> maybe elf64_interpreted_section*)
definition elf_memory_image_section_by_index  :: " nat \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(elf64_interpreted_section)option "  where 
     " elf_memory_image_section_by_index idx1 img3 = ( 
    (* find all element ranges labelled as ELF sections *)
    (let (allSectionTags, allSectionElementRanges) = (elf_memory_image_section_ranges img3) 
    in
    (let matches = (mapMaybei (\<lambda> i .  (\<lambda> tag .  (case  tag of
         FileFeature(ElfSection(itsIdx, s)) => if itsIdx = idx1 then Some s else None
        | _ => failwith (''impossible'')
    ))) allSectionTags)
    in
    (case  matches of
        [] => None
        | [x] => Some x
        | x => failwith ((''impossible: more than one ELF section with same index'') (*( ^ (show idx) ^ )*))
    ))))"


(*val elf_memory_image_element_coextensive_with_section : natural -> elf_memory_image -> maybe string*)
definition elf_memory_image_element_coextensive_with_section  :: " nat \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(string)option "  where 
     " elf_memory_image_element_coextensive_with_section idx1 img3 = ( 
    (* find all element ranges labelled as ELF sections *)
    (let (allSectionTags, allSectionElementRanges) = (elf_memory_image_section_ranges img3) 
    in
    (let matches = (mapMaybei (\<lambda> i .  (\<lambda> (tag, (elName, (rangeStart, rangeLen))) .  (case  tag of
         FileFeature(ElfSection(itsIdx, s)) => 
            (let el_rec = ((case  (elements   img3) elName of
                Some x => x
                | None => failwith (''impossible: element not found'')
            ))
            in
            (let size_matches =                
( 
                (* HMM. This is complicated. Generally we like to ignore 
                 * isec fields that are superseded by memory_image fields, 
                 * here the element length. But we want to catch the case
                 * where there's an inconsistency, and we *might* want to allow the
                 * case where the element length is still vague (Nothing). *)(let range_len_matches_sec = (rangeLen =(elf64_section_size   s))
                in
                (let sec_matches_element_len = (Some((elf64_section_size   s)) =(length1   el_rec))
                in
                (let range_len_matches_element_len = (Some(rangeLen) =(length1   el_rec))
                in
                (* If any pair are unequal, then warn. *)
                (*let _ = 
                if (range_len_matches_sec <> sec_matches_element_len
                 || sec_matches_element_len <> range_len_matches_element_len
                 || range_len_matches_sec <> range_len_matches_element_len)
                then errln (Warning: section lengths do not agree:  ^ s.elf64_section_name_as_string)
                else ()
                in*)
                range_len_matches_element_len))))
            in
            if (itsIdx = idx1) \<and> ((rangeStart =( 0 :: nat)) 
                \<and> size_matches)
            then
            (* *)
            (* Sanity check: does the *)
            Some elName
            else None))
        | _ => failwith (''impossible'')
    ))) (List.zip allSectionTags allSectionElementRanges))
    in
    (case  matches of
        [] => None
        | [x] => Some x
        | xs => failwith ((''impossible: more than one ELF section coextensive with section'') @ ((Lem_string_extra.stringFromNatural idx1) @ (('', names: '')
            @ (string_of_list 
  instance_Show_Show_string_dict xs))))
    ))))"



(*val name_of_elf_interpreted_section : 
    elf64_interpreted_section -> elf64_interpreted_section -> maybe string*)
definition name_of_elf_interpreted_section  :: " elf64_interpreted_section \<Rightarrow> elf64_interpreted_section \<Rightarrow>(string)option "  where 
     " name_of_elf_interpreted_section s shstrtab = ( 
    (case  get_string_at(elf64_section_name   s) (string_table_of_byte_sequence(elf64_section_body   shstrtab)) of
        Success(x) => Some x
        | Fail(e) => None
    ))"


(*val elf_memory_image_sections_with_indices : elf_memory_image -> list (elf64_interpreted_section * natural)*)
definition elf_memory_image_sections_with_indices  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(elf64_interpreted_section*nat)list "  where 
     " elf_memory_image_sections_with_indices img3 = ( 
    (* We have to get all sections and their names,
     * because section names need not be unique. *)
    (let ((all_section_tags :: elf_range_tag list), (all_section_ranges :: element_range list))
     = (elf_memory_image_section_ranges img3)
    in
    List.map (\<lambda> tag .  
        (case  tag of
            FileFeature(ElfSection(idx1, i)) => (i, idx1)
            | _ => failwith (''impossible: non-section in list of sections'')
        )) all_section_tags))"


(*val elf_memory_image_sections : elf_memory_image -> list elf64_interpreted_section*)
definition elf_memory_image_sections  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(elf64_interpreted_section)list "  where 
     " elf_memory_image_sections img3 = ( 
    (let (secs, _) = (list_unzip (elf_memory_image_sections_with_indices img3))
    in secs))"


(*val elf_memory_image_sections_with_name : string -> elf_memory_image -> list elf64_interpreted_section*)
definition elf_memory_image_sections_with_name  :: " string \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(elf64_interpreted_section)list "  where 
     " elf_memory_image_sections_with_name name1 img3 = ( 
    (let all_interpreted_sections = (elf_memory_image_sections img3)
    in
    (let maybe_shstrtab = (elf_memory_image_section_by_index (unat ((elf64_shstrndx  (elf_memory_image_header img3)))) img3)
    in
    (let shstrtab = ((case  maybe_shstrtab of 
        None => failwith (''no shtstrtab'')
        | Some x => x
    ))
    in
    (let all_section_names = (List.map (\<lambda> i .  
        (let (stringtab :: string_table) = (string_table_of_byte_sequence ((elf64_section_body   shstrtab))) in
        (case  get_string_at(elf64_section_name   i) stringtab of
            Fail _ => None
            | Success x => Some x
        ))) all_interpreted_sections)
    in
    mapMaybe (\<lambda> (n, i) .  if Some(name1) = n then Some i else None) (List.zip all_section_names all_interpreted_sections))))))"

(*
val elf_memory_image_unique_section_with_name : string -> elf_memory_image -> elf64_interpreted_section
let elf_memory_image_unique_section_with_name name img = 
    match Map.lookup name img.image with
        Just el -> match el with
            FileFeature(ElfSection(_, x)) -> x
            | _ -> failwith impossible: section name does not name a section
        end
        | 
        | Nothing -> failwith (no section named ' ^ name ^ ' but asserted unique)
    end
*)

(* FIXME: delete these symbol functions, because Memory_image_orderings
 * has generic ones. *)

(*val elf_memory_image_symbol_def_ranges : elf_memory_image -> (list elf_range_tag * list (maybe element_range))*)
definition elf_memory_image_symbol_def_ranges  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>((Abis.any_abi_feature)range_tag)list*((element_range)option)list "  where 
     " elf_memory_image_symbol_def_ranges img3 = ( 
    (* find all element ranges labelled as ELF symbols *)
    (let (tags, maybe_ranges) = (list_unzip (
        tagged_ranges_matching_tag 
  Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict (SymbolDef(null_symbol_definition)) img3
    ))
    in
    (* some symbols, specifically ABS symbols, needn't label a range. *)
    (tags, maybe_ranges)))"


(*val name_of_symbol_def : symbol_definition -> string*)
definition name_of_symbol_def0  :: " symbol_definition \<Rightarrow> string "  where 
     " name_of_symbol_def0 sym1 = ((def_symname   sym1))"


(*val elf_memory_image_defined_symbols_and_ranges : elf_memory_image -> list ((maybe element_range) * symbol_definition)*)
definition elf_memory_image_defined_symbols_and_ranges  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>((element_range)option*symbol_definition)list "  where 
     " elf_memory_image_defined_symbols_and_ranges img3 = ( 
    Memory_image_orderings.defined_symbols_and_ranges 
  Abis.instance_Basic_classes_Ord_Abis_any_abi_feature_dict Abis.instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict img3 )"


(*val elf_memory_image_defined_symbols : elf_memory_image -> list symbol_definition*)
definition elf_memory_image_defined_symbols  :: "(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(symbol_definition)list "  where 
     " elf_memory_image_defined_symbols img3 = ( 
    (let ((all_symbol_tags :: elf_range_tag list), (all_symbol_ranges :: ( element_range option) list))
     = (elf_memory_image_symbol_def_ranges img3)
    in
    Lem_list.mapMaybe (\<lambda> tag .  
        (case  tag of
            SymbolDef(ent) => Some ent
            | _ => failwith (''impossible: non-symbol def in list of symbol defs'')
        )) all_symbol_tags))"


(*
val elf_memory_image_symbols_with_name : string -> elf_memory_image -> list symbol_definition
let elf_memory_image_symbols_with_name name img = 
    let all_interpreted_sections = elf_memory_image_sections img
    in
    let maybe_shstrtab = elf_memory_image_section_by_index (natural_of_elf64_half ((elf_memory_image_header img).elf64_shstrndx)) img
    in
    let shstrtab = match maybe_shstrtab with 
        Nothing -> failwith no shtstrtab
        | Just x -> x
    end
    in
    let all_section_names = List.map (fun i -> 
        let (stringtab : string_table) = string_table_of_byte_sequence (shstrtab.elf64_section_body) in
        match get_string_at i.elf64_section_name stringtab with
            Fail _ -> Nothing
            | Success x -> Just x
        end) all_interpreted_sections
    in
    mapMaybe (fun (n, i) -> if Just(name) = n then Just i else Nothing) (zip all_section_names all_interpreted_sections)
*)
(*
val elf_memory_image_unique_symbol_with_name : string -> elf_memory_image -> symbol_def
let elf_memory_image_unique_symbol_with_name name img = 
    match Map.lookup name img.image with
        Just el -> match el with
            FileFeature(ElfSection(_, x)) -> x
            | _ -> failwith impossible: section name does not name a section
        end
        | 
        | Nothing -> failwith (no section named ' ^ name ^ ' but asserted unique)
    end
*)


(*val name_of_elf_section : elf64_interpreted_section -> elf_memory_image -> maybe string*)
definition name_of_elf_section  :: " elf64_interpreted_section \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(string)option "  where 
     " name_of_elf_section sec img3 = ( 
   (* let shstrndx = natural_of_elf64_half ((elf_memory_image_header img).elf64_shstrndx)
   in
   match elf_memory_image_section_by_index shstrndx img with
        Nothing -> Nothing
        | Just shstrtab -> name_of_elf_interpreted_section sec shstrtab
  end *)
   Some(elf64_section_name_as_string   sec))"


(*val name_of_elf_element : elf_file_feature -> elf_memory_image -> maybe string*)
fun name_of_elf_element  :: " elf_file_feature \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow>(string)option "  where 
     " name_of_elf_element (ElfSection(_, sec)) img3 = ( name_of_elf_section sec img3 )"
|" name_of_elf_element _ img3 = ( None )" 
declare name_of_elf_element.simps [simp del]


(*val get_unique_name_for_section_from_index : natural -> elf64_interpreted_section -> elf_memory_image -> string*)
definition get_unique_name_for_section_from_index  :: " nat \<Rightarrow> elf64_interpreted_section \<Rightarrow>(Abis.any_abi_feature)annotated_memory_image \<Rightarrow> string "  where 
     " get_unique_name_for_section_from_index idx1 isec1 img3 = (
    (* Don't call gensym just to retrieve the name *)
    (case  elf_memory_image_element_coextensive_with_section idx1 img3 of
        Some n => n
        | None => failwith (''section does not have an element name'')
    ))"

end
