chapter {* Generated by Lem from import_everything.lem. *}

theory "Import_everything" 

imports 
 	 Main
	 "Show" 
	 "Missing_pervasives" 
	 "Error" 
	 "Byte_sequence" 
	 "Endianness" 
	 "Elf_types_native_uint" 
	 "Default_printing" 
	 "Elf_header" 
	 "String_table" 
	 "Elf_program_header_table" 
	 "Elf_section_header_table" 
	 "Elf_interpreted_section" 
	 "Elf_interpreted_segment" 
	 "Elf_symbol_table" 
	 "Elf_file" 
	 "Elf_relocation" 
	 "Hex_printing" 
	 "Elf_dynamic" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_dynamic" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_program_header_table" 
	 "Elf_note" 
	 "Multimap" 
	 "Memory_image" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_le_elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_utilities" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_relocation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_section_to_segment_mapping" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_symbol_versioning" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_relocation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_le" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_power64" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_power64_relocation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abis" 
	 "Elf_memory_image" 
	 "Archive" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Harness_interface" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Sail_interface" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_abi" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_note" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Gnu_ext_types_native_uint" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_le_serialisation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_program_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_aarch64_symbol_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_program_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_serialisation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_amd64_symbol_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_power64_dynamic" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_power64_elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_power64_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_x86_relocation" 
	 "Test_image"
begin 

(** [import_everything] imports all Lem files for convenience when testing the
  * Isabelle/HOL4 extractions, etc.
  *
  * XXX: all commented files are part of the linker formalisation and not yet
  *      tested with Isabelle.
  *)

(*open import Abstract_linker_script*)
(*open import Archive*)
(*open import Byte_sequence*)
(*open import Command_line*)
(*open import Default_printing*)
(*open import Elf_dynamic*)
(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_interpreted_section*)
(*open import Elf_interpreted_segment*)
(*open import Elf_memory_image*)
(*open import Elf_memory_image_of_elf64_file*)
(*open import Elf_note*)
(*open import Elf_program_header_table*)
(*open import Elf_relocation*)
(*open import Elf_section_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)
(*open import Endianness*)
(*open import Error*)
(*open import Hex_printing*)
(*open import Input_list
open import Linkable_list
open import Linker_script
open import Link*)
(*open import Memory_image*)
(*open import Memory_image_orderings*)
(*open import Missing_pervasives*)
(*open import Multimap*)
(*open import Show*)
(*open import String_table*)

(*open import Abi_classes*)
(*open import Abis*)
(*open import Abi_utilities*)
(*open import Harness_interface*)
(*open import Sail_interface*)
(*open import Gnu_ext_abi*)
(*open import Gnu_ext_dynamic*)
(*open import Gnu_ext_note*)
(*open import Gnu_ext_program_header_table*)
(*open import Gnu_ext_section_header_table*)
(*open import Gnu_ext_section_to_segment_mapping*)
(*open import Gnu_ext_symbol_versioning*)
(*open import Gnu_ext_types_native_uint*)

(*open import Abi_aarch64_le_elf_header*)
(*open import Abi_aarch64_le*)
(*open import Abi_aarch64_le_serialisation*)
(*open import Abi_aarch64_program_header_table*)
(*open import Abi_aarch64_relocation*)
(*open import Abi_aarch64_section_header_table*)
(*open import Abi_aarch64_symbol_table*)
(*open import Abi_amd64_elf_header*)
(*open import Abi_amd64*)
(*open import Abi_amd64_program_header_table*)
(*open import Abi_amd64_relocation*)
(*open import Abi_amd64_section_header_table*)
(*open import Abi_amd64_serialisation*)
(*open import Abi_amd64_symbol_table*)
(*open import Abi_power64_dynamic*)
(*open import Abi_power64_elf_header*)
(*open import Abi_power64*)
(*open import Abi_power64_relocation*)
(*open import Abi_power64_section_header_table*)
(*open import Abi_x86_relocation*)

(*open import Test_image*)
end
