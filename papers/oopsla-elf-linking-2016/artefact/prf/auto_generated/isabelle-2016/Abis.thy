chapter {* Generated by Lem from abis/abis.lem. *}

theory "Abis" 

imports 
 	 Main
	 "../../lem-libs/isabelle-lib/Lem_num" 
	 "../../lem-libs/isabelle-lib/Lem_list" 
	 "../../lem-libs/isabelle-lib/Lem_set" 
	 "../../lem-libs/isabelle-lib/Lem_basic_classes" 
	 "../../lem-libs/isabelle-lib/Lem_bool" 
	 "../../lem-libs/isabelle-lib/Lem_maybe" 
	 "../../lem-libs/isabelle-lib/Lem_string" 
	 "../../lem-libs/isabelle-lib/Lem_assert_extra" 
	 "Show" 
	 "Missing_pervasives" 
	 "Error" 
	 "Elf_types_native_uint" 
	 "Elf_header" 
	 "../../lem-libs/isabelle-lib/Lem_map" 
	 "Elf_program_header_table" 
	 "Elf_section_header_table" 
	 "Elf_interpreted_section" 
	 "Elf_symbol_table" 
	 "Elf_file" 
	 "Elf_relocation" 
	 "Memory_image" 
	 "Abi_classes" 
	 "Abi_utilities" 
	 "Abi_aarch64_relocation" 
	 "Abi_amd64_relocation" 
	 "Abi_amd64" 
	 "Abi_aarch64_le" 
	 "Abi_power64" 
	 "Abi_power64_relocation" 

begin 

(** The [abis] module is the top-level module for all ABI related code, including
  * some generic functionality that works across all ABIs, and a primitive attempt
  * at abstracting over ABIs for purposes of linking.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import Num*)
(*open import Maybe*)
(*open import List*)
(*open import Set*)
(*open import Map*)
(*open import String*)
(*open import Show*)
(*open import Assert_extra*)
(*open import Error*)
(*open import Missing_pervasives*)

(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_interpreted_section*)
(*open import Elf_relocation*)
(*open import Elf_symbol_table*)
(*open import Elf_program_header_table*)
(*open import Elf_section_header_table*)
(*open import Memory_image*)

(*open import Abi_amd64*)
(*open import Abi_amd64_relocation*)

(*open import Abi_aarch64_le*)
(*open import Abi_aarch64_relocation*)

(*open import Abi_power64*)
(*open import Abi_power64_relocation*)

(*open import Abi_classes*)
(*open import Abi_utilities*)
(*open import Elf_types_native_uint*)

(** Relocation operators and their validity on a given platform *)

(*val is_valid_abi_aarch64_relocation_operator : relocation_operator -> bool*)
fun is_valid_abi_aarch64_relocation_operator  :: " relocation_operator \<Rightarrow> bool "  where 
     " is_valid_abi_aarch64_relocation_operator Page = ( True )"
|" is_valid_abi_aarch64_relocation_operator G = ( True )"
|" is_valid_abi_aarch64_relocation_operator GDat = ( True )"
|" is_valid_abi_aarch64_relocation_operator GLDM = ( True )"
|" is_valid_abi_aarch64_relocation_operator DTPRel = ( True )"
|" is_valid_abi_aarch64_relocation_operator GTPRel = ( True )"
|" is_valid_abi_aarch64_relocation_operator TPRel = ( True )"
|" is_valid_abi_aarch64_relocation_operator GTLSDesc = ( True )"
|" is_valid_abi_aarch64_relocation_operator Delta = ( True )"
|" is_valid_abi_aarch64_relocation_operator LDM = ( True )"
|" is_valid_abi_aarch64_relocation_operator TLSDesc = ( True )"
|" is_valid_abi_aarch64_relocation_operator Indirect = ( True )"
|" is_valid_abi_aarch64_relocation_operator _ = ( False )" 
declare is_valid_abi_aarch64_relocation_operator.simps [simp del]

  
(*val is_valid_abi_aarch64_relocation_operator2 : relocation_operator2 -> bool*)
fun is_valid_abi_aarch64_relocation_operator2  :: " relocation_operator2 \<Rightarrow> bool "  where 
     " is_valid_abi_aarch64_relocation_operator2 GTLSIdx = ( True )" 
declare is_valid_abi_aarch64_relocation_operator2.simps [simp del]


(*val is_valid_abi_amd64_relocation_operator : relocation_operator -> bool*)
fun is_valid_abi_amd64_relocation_operator  :: " relocation_operator \<Rightarrow> bool "  where 
     " is_valid_abi_amd64_relocation_operator Indirect = ( True )"
|" is_valid_abi_amd64_relocation_operator _ = ( False )" 
declare is_valid_abi_amd64_relocation_operator.simps [simp del]

  
(*val is_valid_abi_amd64_relocation_operator2 : relocation_operator2 -> bool*)
definition is_valid_abi_amd64_relocation_operator2  :: " relocation_operator2 \<Rightarrow> bool "  where 
     " is_valid_abi_amd64_relocation_operator2 _ = ( False )"


(*val is_valid_abi_power64_relocation_operator : relocation_operator -> bool*)
definition is_valid_abi_power64_relocation_operator  :: " relocation_operator \<Rightarrow> bool "  where 
     " is_valid_abi_power64_relocation_operator op1 = ( False )"
 (* TODO *)

(*val is_valid_abi_power64_relocation_operator2 : relocation_operator2 -> bool*)
definition is_valid_abi_power64_relocation_operator2  :: " relocation_operator2 \<Rightarrow> bool "  where 
     " is_valid_abi_power64_relocation_operator2 _ = ( False )"


(** Misc. ABI related stuff *)

datatype any_abi_feature = Amd64AbiFeature " amd64_abi_feature "
                     | Aarch64LeAbiFeature " aarch64_le_abi_feature "

(*val anyAbiFeatureCompare : any_abi_feature -> any_abi_feature -> Basic_classes.ordering*)
fun anyAbiFeatureCompare  :: " any_abi_feature \<Rightarrow> any_abi_feature \<Rightarrow> ordering "  where 
     " anyAbiFeatureCompare (Amd64AbiFeature(af1)) (Amd64AbiFeature(af2)) = ( Abi_amd64.abiFeatureCompare0 af1 af2 )"
|" anyAbiFeatureCompare (Amd64AbiFeature(_)) _ = ( LT )"
|" anyAbiFeatureCompare (Aarch64LeAbiFeature(af1)) (Amd64AbiFeature(af2)) = ( GT )"
|" anyAbiFeatureCompare (Aarch64LeAbiFeature(af1)) (Aarch64LeAbiFeature(af2)) = ( abiFeatureCompare af1 af2 )" 
declare anyAbiFeatureCompare.simps [simp del]


(*val anyAbiFeatureTagEquiv : any_abi_feature -> any_abi_feature -> bool*)
fun anyAbiFeatureTagEquiv  :: " any_abi_feature \<Rightarrow> any_abi_feature \<Rightarrow> bool "  where 
     " anyAbiFeatureTagEquiv (Amd64AbiFeature(af1)) (Amd64AbiFeature(af2)) = ( Abi_amd64.abiFeatureTagEq0 af1 af2 )"
|" anyAbiFeatureTagEquiv (Amd64AbiFeature(_)) _ = ( False )"
|" anyAbiFeatureTagEquiv (Aarch64LeAbiFeature(af1)) (Amd64AbiFeature(af2)) = ( False )"
|" anyAbiFeatureTagEquiv (Aarch64LeAbiFeature(af1)) (Aarch64LeAbiFeature(af2)) = ( abiFeatureTagEq af1 af2 )" 
declare anyAbiFeatureTagEquiv.simps [simp del]


definition instance_Basic_classes_Ord_Abis_any_abi_feature_dict  :: "(any_abi_feature)Ord_class "  where 
     " instance_Basic_classes_Ord_Abis_any_abi_feature_dict = ((|

  compare_method = anyAbiFeatureCompare,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (anyAbiFeatureCompare f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (anyAbiFeatureCompare f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (anyAbiFeatureCompare f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (anyAbiFeatureCompare f1 f2) ({GT, EQ})))|) )"


definition instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict  :: "(any_abi_feature)AbiFeatureTagEquiv_class "  where 
     " instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict = ((|

  abiFeatureTagEquiv_method = anyAbiFeatureTagEquiv |) )"


definition make_elf64_header  :: " nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> elf64_header "  where 
     " make_elf64_header data osabi abiv ma t entry shoff phoff phnum shnum shstrndx = (
      (| elf64_ident    = [elf_mn_mag0, elf_mn_mag1, elf_mn_mag2, elf_mn_mag3, 
                           Elf_Types_Local.unsigned_char_of_nat elf_class_64, 
                           Elf_Types_Local.unsigned_char_of_nat data,
                           Elf_Types_Local.unsigned_char_of_nat elf_ev_current,
                           Elf_Types_Local.unsigned_char_of_nat osabi,
                           Elf_Types_Local.unsigned_char_of_nat abiv,
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat)),
                           Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat))]
       , elf64_type     = (Elf_Types_Local.uint16_of_nat t)
       , elf64_machine  = (Elf_Types_Local.uint16_of_nat ma)
       , elf64_version  = (Elf_Types_Local.uint32_of_nat elf_ev_current)
       , elf64_entry    = (Elf_Types_Local.uint64_of_nat entry)
       , elf64_phoff    = (Elf_Types_Local.uint64_of_nat phoff)
       , elf64_shoff    = (Elf_Types_Local.uint64_of_nat shoff)
       , elf64_flags    = (Elf_Types_Local.uint32_of_nat(( 0 :: nat)))
       , elf64_ehsize   = (Elf_Types_Local.uint16_of_nat(( 64 :: nat)))
       , elf64_phentsize= (Elf_Types_Local.uint16_of_nat(( 56 :: nat)))
       , elf64_phnum    = (Elf_Types_Local.uint16_of_nat phnum)
       , elf64_shentsize= (Elf_Types_Local.uint16_of_nat(( 64 :: nat)))
       , elf64_shnum    = (Elf_Types_Local.uint16_of_nat shnum)
       , elf64_shstrndx = (Elf_Types_Local.uint16_of_nat shstrndx)
       |) )"


(*val make_load_phdrs : forall 'abifeature. natural -> natural -> annotated_memory_image 'abifeature -> list elf64_interpreted_section -> list elf64_program_header_table_entry*)
definition make_load_phdrs  :: " nat \<Rightarrow> nat \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>(elf64_interpreted_section)list \<Rightarrow>(elf64_program_header_table_entry)list "  where 
     " make_load_phdrs max_page_sz common_page_sz img3 section_pairs_bare_sorted_by_address = ( 
    (let (phdr_flags_from_section_flags :: nat \<Rightarrow> string \<Rightarrow> nat) = (\<lambda> section_flags .  \<lambda> sec_name . 
        (let flags = (natural_lor elf_pf_r (natural_lor 
            (if flag_is_set shf_write section_flags then elf_pf_w else( 0 :: nat))
            (if flag_is_set shf_execinstr section_flags then elf_pf_x else( 0 :: nat))))
        in
        (*let _ = errln (Phdr flags of section  ^ sec_name ^ (ELF section flags 0x  ^ 
            (hex_string_of_natural section_flags) ^ ) are 0x ^ (hex_string_of_natural flags))
        in*)
        flags))
    in
    (let maybe_extend_phdr = (\<lambda> phdr .  \<lambda> isec1 .  ( 
        (let new_p_type = (unat(elf64_p_type   phdr))
        in
        (let this_section_phdr_flags = (phdr_flags_from_section_flags(elf64_section_flags   isec1)(elf64_section_name_as_string   isec1))
        in
        (let can_combine_flags = (\<lambda> flagsets .  
            (* The GNU linker happily adds a .rodata section to a RX segment,
             * but not to a RW segment. So the only clear rule is: if any is writable,
             * all must be writable. *)
            (let is_writable = (\<lambda> flags .  natural_land flags elf_pf_w = elf_pf_w)
            in
            (let flagslist = (list_of_set flagsets)
            in
            (let union_flags = (List.foldl natural_lor(( 0 :: nat)) flagslist)
            in
            if ((\<exists> x \<in> (set flagslist).  is_writable x))
            then
                if ((\<forall> x \<in> (set flagslist).  is_writable x)) then Some union_flags
                else None
            else
                Some union_flags))))
        in
        (let maybe_extended_flags = (can_combine_flags { this_section_phdr_flags, unat(elf64_p_flags   phdr) })
        in
        if maybe_extended_flags = None then (*let _ = errln flag mismatch in*) None
        else (let new_p_flags = ((case  maybe_extended_flags of Some flags => flags | _ => failwith (''impossible'') ))
        in
        (* The new filesz is the file end offset of this section,
         * minus the existing file start offset of the phdr. 
         * Check that the new section begins after the old offset+filesz. *)
        if(elf64_section_offset   isec1) < ((unat(elf64_p_offset   phdr)) + (unat(elf64_p_filesz   phdr)))
        then (*let _ = errln offset went backwards in*) None
        else 
        (let new_p_filesz = (unat(elf64_p_filesz   phdr) + (if(elf64_section_type   isec1) = sht_progbits then(elf64_section_size   isec1) else( 0 :: nat)))
        in 
        (* The new memsz is the virtual address end address of this section,
         * minus the existing start vaddr of the phdr. 
         * Check that the new section begins after the old vaddr+memsz. *)
        if(elf64_section_addr   isec1) < ((unat(elf64_p_vaddr   phdr)) + (unat(elf64_p_memsz   phdr)))
        then (*let _ = errln vaddr went backwards in*) None
        else 
        (let new_p_memsz = (unat(elf64_p_memsz   phdr) +(elf64_section_size   isec1))
        in
        (let (one_if_zero :: nat \<Rightarrow> nat) = (\<lambda> n .  if n =( 0 :: nat) then( 1 :: nat) else n)
        in
        (let new_p_align =  (GCD.lcm (one_if_zero (unat(elf64_p_align   phdr))) (one_if_zero(elf64_section_align   isec1)))
        in
        Some
          (| elf64_p_type   = (Elf_Types_Local.uint32_of_nat new_p_type)
           , elf64_p_flags  = (Elf_Types_Local.uint32_of_nat new_p_flags)
           , elf64_p_offset =(elf64_p_offset   phdr)
           , elf64_p_vaddr  =(elf64_p_vaddr   phdr)
           , elf64_p_paddr  =(elf64_p_paddr   phdr)
           , elf64_p_filesz = (of_int (int new_p_filesz))
           , elf64_p_memsz  = (of_int (int new_p_memsz))
           , elf64_p_align  = (of_int (int new_p_align))
           |))))))))))
    ))
    in
    (let rounded_down_offset = (\<lambda> isec1 .  round_down_to common_page_sz(elf64_section_offset   isec1))
    in
    (let offset_round_down_amount = (\<lambda> isec1 . (elf64_section_offset   isec1) - (rounded_down_offset isec1))
    in
    (let rounded_down_vaddr = (\<lambda> isec1 .  round_down_to common_page_sz(elf64_section_addr   isec1))
    in
    (let vaddr_round_down_amount = (\<lambda> isec1 . (elf64_section_addr   isec1) - (rounded_down_vaddr isec1))
    in
    (let new_phdr = (\<lambda> isec1 .  
      (| elf64_p_type   = (Elf_Types_Local.uint32_of_nat elf_pt_load) (** Type of the segment *)
       , elf64_p_flags  = (Elf_Types_Local.uint32_of_nat (phdr_flags_from_section_flags(elf64_section_flags   isec1)(elf64_section_name_as_string   isec1))) (** Segment flags *)
       , elf64_p_offset = (Elf_Types_Local.uint64_of_nat (rounded_down_offset isec1)) (** Offset from beginning of file for segment *)
       , elf64_p_vaddr  = (Elf_Types_Local.uint64_of_nat (rounded_down_vaddr isec1)) (** Virtual address for segment in memory *)
       , elf64_p_paddr  = (Elf_Types_Local.uint64_of_nat(( 0 :: nat))) (** Physical address for segment *)
       , elf64_p_filesz = (of_int (int (if(elf64_section_type   isec1) = sht_nobits then( 0 :: nat) else(elf64_section_size   isec1) + (offset_round_down_amount isec1)))) (** Size of segment in file, in bytes *)
       , elf64_p_memsz  = (of_int (int ((elf64_section_size   isec1) + (vaddr_round_down_amount isec1)))) (** Size of segment in memory image, in bytes *)
       , elf64_p_align  = (of_int (int  (* isec.elf64_section_align *)max_page_sz)) (** Segment alignment memory for memory and file *)
       |))
    in
    (* accumulate sections into the phdr *)
    (let rev_list = (List.foldl (\<lambda> accum_phdr_list .  (\<lambda> isec1 .  (
        (* Do we have a current phdr? *)
        (case  accum_phdr_list of
            [] => (* no, so make one *)
                (*let _ = errln (Starting the first LOAD phdr for section  ^ isec.elf64_section_name_as_string)
                in*)
                [new_phdr isec1]
            | current_phdr # more1 => 
                (* can we extend it with the current section? *)
                (case  maybe_extend_phdr current_phdr isec1 of
                    None => 
                        (*let _ = errln (Starting new LOAD phdr for section  ^ isec.elf64_section_name_as_string)
                        in*)
                        (new_phdr isec1) # (current_phdr # more1)
                    | Some phdr => phdr # more1
                )
        )
    ))) [] (List.filter (\<lambda> isec1 .  flag_is_set shf_alloc(elf64_section_flags   isec1)
        \<and> \<not> (flag_is_set shf_tls(elf64_section_flags   isec1))) section_pairs_bare_sorted_by_address))
    in
    (*let _ = errln Successfully made phdrs
    in*)
    List.rev rev_list)))))))))"

    
(*val make_default_phdrs : forall 'abifeature. natural -> natural -> natural (* file type *) -> annotated_memory_image 'abifeature -> list elf64_interpreted_section -> list elf64_program_header_table_entry*)
definition make_default_phdrs  :: " nat \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>(elf64_interpreted_section)list \<Rightarrow>(elf64_program_header_table_entry)list "  where 
     " make_default_phdrs maxpagesize1 commonpagesize1 t img3 section_pairs_bare_sorted_by_address = ( 
    (* FIXME: do the shared object and dyn. exec. stuff too *)
    make_load_phdrs maxpagesize1 commonpagesize1 img3 section_pairs_bare_sorted_by_address )"


(*val find_start_symbol_address : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => annotated_memory_image 'abifeature -> maybe natural*)
definition find_start_symbol_address  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>(nat)option "  where 
     " find_start_symbol_address dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3 = ( 
    (* Do we have a symbol called _start? *)
    (let all_defs = (Memory_image_orderings.defined_symbols_and_ranges 
  dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3)
    in
    (let get_entry_point = (\<lambda> (maybe_range, symbol_def) .  
        if(def_symname   symbol_def) = (''_start'')
        then Some (maybe_range, symbol_def) 
        else None
    )
    in
    (let all_entry_points = (Lem_list.mapMaybe get_entry_point all_defs)
    in
    (case  all_entry_points of
        [(maybe_range, symbol_def)] =>
            (case  maybe_range of
                Some (el_name, (el_off, len)) => 
                    (case  (elements   img3) el_name of
                        None => failwith (([(CHR ''_''), (CHR ''s''), (CHR ''t''), (CHR ''a''), (CHR ''r''), (CHR ''t''), (CHR '' ''), (CHR ''s''), (CHR ''y''), (CHR ''m''), (CHR ''b''), (CHR ''o''), (CHR ''l''), (CHR '' ''), (CHR ''d''), (CHR ''e''), (CHR ''f''), (CHR ''i''), (CHR ''n''), (CHR ''e''), (CHR ''d''), (CHR '' ''), (CHR ''i''), (CHR ''n''), (CHR '' ''), (CHR ''n''), (CHR ''o''), (CHR ''n''), (CHR ''e''), (CHR ''x''), (CHR ''i''), (CHR ''s''), (CHR ''t''), (CHR ''e''), (CHR ''n''), (CHR ''t''), (CHR '' ''), (CHR ''e''), (CHR ''l''), (CHR ''e''), (CHR ''m''), (CHR ''e''), (CHR ''n''), (CHR ''t''), (CHR '' ''), (Char Nibble6 Nibble0)]) @ (el_name @ ([(Char Nibble2 Nibble7)])))
                        | Some el_rec => 
                            (case (startpos   el_rec) of
                                None => (*let _ = Missing_pervasives.errln warning: saw `_start' in element with no assigned address in *)None
                                | Some x => (* success! *) Some (x + el_off)
                            )
                    )
                | _ => (*let _ = Missing_pervasives.errln warning: `_start' symbol with no range in*) None
            )
        | [] => (* no _start symbol *) None
        | _ => (*let _ = Missing_pervasives.errln (warning: saw multiple `_start' symbols:  ^
            (let (ranges, defs) = unzip all_entry_points in show ranges)) in *)None
    )))))"


(*val pad_zeroes : natural -> list byte*)
definition pad_zeroes  :: " nat \<Rightarrow>(Elf_Types_Local.byte)list "  where 
     " pad_zeroes n = ( List.replicate n ((of_nat (( 0 :: nat)) :: byte)))"


(*val pad_0x90 : natural -> list byte*)
definition pad_0x90  :: " nat \<Rightarrow>(Elf_Types_Local.byte)list "  where 
     " pad_0x90 n = ( List.replicate n ((of_nat (( 9 :: nat) *( 16 :: nat)) :: byte)))"


(* null_abi captures ABI details common to all ELF-based, System V-based systems.
 * HACK: for now, specialise to 64-bit ABIs. *)
(*val null_abi : abi any_abi_feature*) 
definition null_abi  :: "(any_abi_feature)abi "  where 
     " null_abi = ( (|
      is_valid_elf_header = is_valid_elf64_header
    , make_elf_header = (make_elf64_header elf_data_2lsb elf_osabi_none(( 0 :: nat)) elf_ma_none)
    , reloc = noop_reloc
    , section_is_special = elf_section_is_special
    , section_is_large = (\<lambda> s .  (\<lambda> f .  False))
    , maxpagesize =((( 2 :: nat) *( 256 :: nat)) *( 4096 :: nat)) (* 2MB; bit of a guess, based on gdb and prelink code *)
    , minpagesize =(( 1024 :: nat)) (* bit of a guess again *)
    , commonpagesize =(( 4096 :: nat))
    , symbol_is_generated_by_linker = (\<lambda> symname .  symname = (''_GLOBAL_OFFSET_TABLE_''))
    , make_phdrs = make_default_phdrs
    , max_phnum =(( 2 :: nat))
    , guess_entry_point = 
  (find_start_symbol_address
     instance_Basic_classes_Ord_Abis_any_abi_feature_dict
     instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict)
    , pad_data = pad_zeroes
    , pad_code = pad_zeroes
    , generate_support = ( (* fun _ -> *)\<lambda> _ .  get_empty_memory_image () )
    , concretise_support = (\<lambda> img3 .  img3)
    |) )"


(* *)
(*val amd64_generate_support : (* list (list reloc_site_resolution) -> *) list (annotated_memory_image any_abi_feature) -> annotated_memory_image any_abi_feature*)
definition amd64_generate_support  :: "((any_abi_feature)annotated_memory_image)list \<Rightarrow>(any_abi_feature)annotated_memory_image "  where 
     " amd64_generate_support (* reloc_resolution_lists *) input_imgs = ( 
    (* We generate a basic GOT. At the moment we can only describe the GOT
     * contents abstractly, not as its binary content, because addresses
     * have not yet been fixed. 
     * 
     * To do this, we create a set of Abi_amd64.GOTEntry records, one for
     * each distinct symbol that is referenced by one or more GOT-based relocations.
     * To enumerate these, we look at all the symbol refs in the image.
     *)
    (let tags_and_ranges_by_image = (Lem_list.mapi (\<lambda> i .  \<lambda> img3 . 
        (i, Multimap.lookupBy0 
  (Memory_image_orderings.instance_Basic_classes_Ord_Memory_image_range_tag_dict
     instance_Basic_classes_Ord_Abis_any_abi_feature_dict) (instance_Basic_classes_Ord_Maybe_maybe_dict
   (instance_Basic_classes_Ord_tup2_dict
      Lem_string_extra.instance_Basic_classes_Ord_string_dict
      (instance_Basic_classes_Ord_tup2_dict
         instance_Basic_classes_Ord_Num_natural_dict
         instance_Basic_classes_Ord_Num_natural_dict)))  (Memory_image_orderings.tagEquiv
    instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict) (SymbolRef(null_symbol_reference_and_reloc_site))(by_tag   img3))
    ) input_imgs)
    in
    (let refs_via_got = (list_concat_map (\<lambda> (i, tags_and_ranges) .  Lem_list.mapMaybe (\<lambda> (tag, maybe_range) .  (case  tag of
         SymbolRef(rr) => 
            (* Is this ref a relocation we're going to apply, and does it reference the GOT? *)
            (case  ((maybe_reloc   rr),(maybe_def_bound_to   rr)) of
                (None, _) => None
                | (Some r, Some(ApplyReloc, maybe_def)) =>
                    if (get_elf64_relocation_a_type(ref_relent   r) \<in> {
                        r_x86_64_got32, r_x86_64_gotpcrel, r_x86_64_gottpoff, r_x86_64_gotoff64, r_x86_64_gotpc32, r_x86_64_gotpc32_tlsdesc
                    }) then Some (i,(ref_symname  (ref   rr)), (maybe_range, rr)) else None
                | (Some r, Some(MakePIC, maybe_def)) => failwith (''FIXME: PIC support please'')
            )
         | _ => failwith (''impossible: reloc site tag is not a SymbolRef'')
    )) tags_and_ranges) tags_and_ranges_by_image)
    in
    (let (idxs, symnames, items) = (unzip3 refs_via_got)
    in
    (* We now have our list of symbols. How many distinct symbols? *)
    (let by_symname = (List.foldl (\<lambda> acc1 .  \<lambda> (idx1, symname, item) .  map_update symname ((case   acc1 symname of 
            None => [item]
            | Some l => item # l
        )) acc1) Map.empty refs_via_got)
    in
    (let nentries = ( (card (Map.dom by_symname)))
    in
    (let entrysize =(( 8 :: nat))
    in
    (let new_by_range = ({
        (Some((''.got''), (( 0 :: nat), (nentries * entrysize))), AbiFeature(Amd64AbiFeature(Abi_amd64.GOT0(List.zip symnames items))))
    ,   (Some((''.got''), (( 0 :: nat), (nentries * entrysize))), FileFeature(ElfSection(( 1 :: nat), 
          (| elf64_section_name =(( 0 :: nat)) (* ignored *)
           , elf64_section_type = sht_progbits
           , elf64_section_flags = (natural_lor shf_write shf_alloc)
           , elf64_section_addr =(( 0 :: nat)) (* ignored -- covered by element *)
           , elf64_section_offset =(( 0 :: nat)) (* ignored -- will be replaced when file offsets are assigned *)
           , elf64_section_size = (nentries * entrysize) (* ignored *)
           , elf64_section_link =(( 0 :: nat))
           , elf64_section_info =(( 0 :: nat))
           , elf64_section_align =(( 8 :: nat))
           , elf64_section_entsize =(( 8 :: nat))
           , elf64_section_body = Byte_sequence.empty (* ignored *)
           , elf64_section_name_as_string = (''.got'')
           |)
        )))
    ,   (* FIXME: _GLOBAL_OFFSET_TABLE_ generally doesn't mark the *start* of the GOT; 
         * it's some distance in. What about .got.plt? *)
        (Some((''.got''), (( 0 :: nat), (nentries * entrysize))), SymbolDef((|
              def_symname = (''_GLOBAL_OFFSET_TABLE_'')
            , def_syment =    (| elf64_st_name  = (Elf_Types_Local.uint32_of_nat(( 0 :: nat))) (* ignored *)
                               , elf64_st_info  = (Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat))) (* FIXME *)
                               , elf64_st_other = (Elf_Types_Local.unsigned_char_of_nat(( 0 :: nat))) (* FIXME *)
                               , elf64_st_shndx = (Elf_Types_Local.uint16_of_nat(( 1 :: nat)))
                               , elf64_st_value = (Elf_Types_Local.uint64_of_nat(( 0 :: nat))) (* ignored *)
                               , elf64_st_size  = (of_int (int (nentries * entrysize))) (* FIXME: start later, smaller size? zero size? *)
                               |)
            , def_sym_scn =(( 1 :: nat))
            , def_sym_idx =(( 1 :: nat))
            , def_linkable_idx =(( 0 :: nat))
            |)))
    })
    in
    (|  elements = (map_update (''.got'') (|
                    startpos = None
               ,    length1 = (Some (nentries * entrysize))
               ,    contents = []
               |) Map.empty)
     ,   by_range = new_by_range,   by_tag = (by_tag_from_by_range new_by_range)
      
     |)))))))))"


(*val amd64_concretise_support : annotated_memory_image any_abi_feature -> annotated_memory_image any_abi_feature*)
definition amd64_concretise_support  :: "(any_abi_feature)annotated_memory_image \<Rightarrow>(any_abi_feature)annotated_memory_image "  where 
     " amd64_concretise_support img3 = ( 
    (* Fill in the GOT contents. *)
    (case  (elements   img3) (''.got'') of
        None => (* got no GOT? okay... *) img3
        | Some got => 
            (* Find the GOT tag. *)
            (let tags_and_ranges = (Multimap.lookupBy0 
  (Memory_image_orderings.instance_Basic_classes_Ord_Memory_image_range_tag_dict
     instance_Basic_classes_Ord_Abis_any_abi_feature_dict) (instance_Basic_classes_Ord_Maybe_maybe_dict
   (instance_Basic_classes_Ord_tup2_dict
      Lem_string_extra.instance_Basic_classes_Ord_string_dict
      (instance_Basic_classes_Ord_tup2_dict
         instance_Basic_classes_Ord_Num_natural_dict
         instance_Basic_classes_Ord_Num_natural_dict)))  (Memory_image_orderings.tagEquiv
    instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict) (AbiFeature(Amd64AbiFeature(Abi_amd64.GOT0([]))))(by_tag   img3))
            in
            (case  tags_and_ranges of
                [] => failwith (''error: GOT element but no ABI feature GOT tag'')
                | [(AbiFeature(Amd64AbiFeature(Abi_amd64.GOT0(l))), Some(el_name, (start, len)))] => img3 (* FIXME *)
                | _ => failwith (''bad or multiple GOT tags'')
            ))
    ))"


(*val sysv_amd64_std_abi : abi any_abi_feature*)
definition sysv_amd64_std_abi  :: "(any_abi_feature)abi "  where 
     " sysv_amd64_std_abi = ( 
   (| is_valid_elf_header = header_is_amd64
    , make_elf_header = (make_elf64_header elf_data_2lsb elf_osabi_none(( 0 :: nat)) elf_ma_x86_64)
    , reloc = (amd64_reloc instance_Basic_classes_Ord_Abis_any_abi_feature_dict
    instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict)
    , section_is_special = section_is_special0
    , section_is_large = (\<lambda> s .  (\<lambda> f .  flag_is_set shf_x86_64_large(elf64_section_flags   s)))
    , maxpagesize =(( 65536 :: nat))
    , minpagesize =(( 4096 :: nat))
    , commonpagesize =(( 4096 :: nat))
      (* XXX: DPM, changed from explicit reference to null_abi field due to problems in HOL4. *)
    , symbol_is_generated_by_linker = (\<lambda> symname .  symname = (''_GLOBAL_OFFSET_TABLE_''))
    , make_phdrs = make_default_phdrs
    , max_phnum =(( 4 :: nat))
    , guess_entry_point = 
  (find_start_symbol_address
     instance_Basic_classes_Ord_Abis_any_abi_feature_dict
     instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict)
    , pad_data = pad_zeroes
    , pad_code = pad_0x90
    , generate_support = amd64_generate_support
    , concretise_support = amd64_concretise_support
    |) )"


(*val sysv_aarch64_le_std_abi : abi any_abi_feature*)
definition sysv_aarch64_le_std_abi  :: "(any_abi_feature)abi "  where 
     " sysv_aarch64_le_std_abi = ( 
   (| is_valid_elf_header = header_is_aarch64_le
    , make_elf_header = (make_elf64_header elf_data_2lsb elf_osabi_none(( 0 :: nat)) elf_ma_aarch64)
    , reloc = aarch64_le_reloc
    , section_is_special = section_is_special0
    , section_is_large = (\<lambda> _ .  (\<lambda> _ .  False))
    , maxpagesize =((( 2 :: nat) *( 256 :: nat)) *( 4096 :: nat)) (* 2MB; bit of a guess, based on gdb and prelink code *)
    , minpagesize =(( 1024 :: nat)) (* bit of a guess again *)
    , commonpagesize =(( 4096 :: nat))
    , symbol_is_generated_by_linker = (\<lambda> symname .  symname = (''_GLOBAL_OFFSET_TABLE_''))
    , make_phdrs = make_default_phdrs
    , max_phnum =(( 5 :: nat))
    , guess_entry_point = 
  (find_start_symbol_address
     instance_Basic_classes_Ord_Abis_any_abi_feature_dict
     instance_Abi_classes_AbiFeatureTagEquiv_Abis_any_abi_feature_dict)
    , pad_data = pad_zeroes
    , pad_code = pad_zeroes
    , generate_support = ( (* fun _ -> *)\<lambda> _ .  get_empty_memory_image () )
    , concretise_support = (\<lambda> img3 .  img3)
    |) )"


(*val all_abis : list (abi any_abi_feature)*)
definition all_abis  :: "((any_abi_feature)abi)list "  where 
     " all_abis = ( [sysv_amd64_std_abi, sysv_aarch64_le_std_abi, null_abi])"


end
