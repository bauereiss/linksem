chapter {* Generated by Lem from elf_symbol_table.lem. *}

theory "Elf_symbol_tableAuxiliary" 

imports 
 	 Main "~~/src/HOL/Library/Code_Target_Numeral"
	 (* IMPORTS MASKED FOR ANONYMOUS REVIEW *)

begin 


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

termination read_elf32_symbol_table by lexicographic_order

termination read_elf64_symbol_table by lexicographic_order



end