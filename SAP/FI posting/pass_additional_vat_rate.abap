METHOD /medius/if_badi_fi_invoice~modify_input_post.
    *
    * Example of how to pass information from a custom field in Medius to a field within the BKPF table as it is not exposed in the BAPI_ACC_DOCUMENT_POST
    * Pass rate from a Medius numeric custom field to BKPF-CTXKRS
    *
    DATA: ls_extension2 TYPE bapiparex
    .
    
    IF is_header-customfield_numeric2 IS NOT INITIAL.
    CLEAR ls_extension2.
          ls_extension2-structure = 'BKPF-CTXKRS'.
          ls_extension2-valuepart1 = is_header-customfield_numeric2.
    CONDENSE ls_extension2-valuepart1.
    APPEND ls_extension2 TO it_extension2.
    ENDIF.
    
ENDMETHOD.

METHOD if_ex_acc_document~change.
    *
    * Move rate from extension table to the final field in BKPF
    *
    DATA: w_accit     TYPE accit,
                w_extension TYPE bapiparex.
    
    LOOP AT c_extension2 INTO w_extension.
    
    CASE w_extension-structure.
    WHEN 'BKPF-CTXKRS'.
    LOOP AT c_accit INTO w_accit.
                w_accit-ctxkrs = w_extension-valuepart1.
    MODIFY c_accit FROM w_accit INDEX sy-tabix TRANSPORTING ctxkrs.
    ENDLOOP.
    ENDCASE.
    
    ENDLOOP.
    
ENDMETHOD.