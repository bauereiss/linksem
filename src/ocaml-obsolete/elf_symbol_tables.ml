open Bitstring

open Elf_section
open Error_monad

type elf_symbol_table_entry =
	{ st_name  : Int64.t
	; st_value : Int64.t
	; st_size  : Int64.t
	; st_info  : Int64.t
	; st_other : Int64.t
	; st_shndx : Int64.t
	}
	
type elf_symbol_table = elf_symbol_table_entry list

let elf32_st_name_width = 32
let elf32_st_value_width = 32
let elf32_st_size_width = 32
let elf32_st_info_width = 32
let elf32_st_other_width = 32
let elf32_st_shndx_width = 32

let elf32_symbol_table_entry_width =
	elf32_st_name_width +
	elf32_st_value_width +
	elf32_st_size_width +
	elf32_st_info_width +
	elf32_st_other_width +
	elf32_st_shndx_width
;;	

let read_elf32_symbol_table_entry bitstream =
	bitmatch bitstream with
		| { st_name : elf32_st_name_width : littleendian
		  ; st_value : elf32_st_value_width : littleendian
		  ; st_size : elf32_st_size_width : littleendian
		  ; st_info : elf32_st_info_width : littleendian
		  ; st_other : elf32_st_other_width : littleendian
		  ; st_shndx : elf32_st_shndx_width : littleendian
		  } ->
		  	Success {
		  		st_name; st_value; st_size; st_info; st_other; st_shndx
		  	}
		| { _ } -> Error "read_elf32_symbol_table_entry: unable to read table entry"
;;

let string_of_symbol_table_entry entry =
	BatString.concat "\n" [
		"ELF symbol table name: " ^ Utility.hex_string_of_int64 entry.st_name
	; "ELF symbol table value: " ^ Utility.hex_string_of_int64 entry.st_value
	; "ELF symbol table size: " ^ Utility.hex_string_of_int64 entry.st_size
	; "ELF symbol table info: " ^ Utility.hex_string_of_int64 entry.st_info
	; "ELF symbol table other: " ^ Utility.hex_string_of_int64 entry.st_other
	; "ELF symbol table section header table index: " ^ Utility.hex_string_of_int64 entry.st_shndx
	]
;;

let rec read_elf32_symbol_table_entries offsets_sizes bitstream =
	match offsets_sizes with
		| []    -> return []
		| x::xs ->
			let (offset, size) = x in
			let _, initial = Utility.partition_bitstring offset bitstream in
			let relevant, _ = Utility.partition_bitstring size initial in
				read_elf32_symbol_table_entry relevant >>= fun entry ->
				read_elf32_symbol_table_entries xs bitstream >>= fun entries ->
				return (entry::entries)
;;

let read_elf32_symbol_tables sections bitstream =
	let symtab_sections = List.filter (fun sect -> Int64.to_int sect.sh_type = 2 || Int64.to_int sect.sh_type = 3) sections in
	let offsets_sizes = List.map (fun sect ->
		let offset = Int64.to_int sect.sh_offset * 8 in
		let size   = Int64.to_int sect.sh_size * 8 in
			offset, size) symtab_sections
		in
			read_elf32_symbol_table_entries offsets_sizes bitstream
;;