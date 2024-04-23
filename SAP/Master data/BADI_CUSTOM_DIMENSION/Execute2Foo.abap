METHOD /medius/if_badi_custom_dimensi~execute2.
  DATA:
    ls_dimension         TYPE /medius/scustom_dimension,
    lv_comp_code         TYPE bukrs,
    lv_index             TYPE string,
    lv_records_to_return TYPE i,
    lv_value             TYPE string.

  IF ii_offset EQ 0.
    lv_records_to_return = ii_number_of_records.
  ELSEIF ii_offset EQ ii_number_of_records.
    lv_records_to_return = ii_number_of_records / 2.
  ENDIF.

  lv_value = 'foo'.

  IF ic_language EQ 'V'.
    lv_value = 'föö'.
  ENDIF.

  DO lv_records_to_return TIMES.
    lv_index = sy-index.

    LOOP AT it_comp_code
    INTO lv_comp_code.
      ls_dimension-comp_code = lv_comp_code.
      ls_dimension-is_active = abap_true.

      IF lv_index EQ 2.
        ls_dimension-is_active = abap_false.
      ENDIF.

      IF NOT ic_mode EQ /medius/if=>c_mode_changes_and_expiring
        AND lv_index EQ 3.
        CONTINUE.
      ENDIF.

      IF ic_mode EQ /medius/if=>c_mode_all_entries
        AND ls_dimension-is_active EQ abap_false.
        CONTINUE.
      ENDIF.

      CONCATENATE '2' lv_value lv_index INTO ls_dimension-value.
      CONCATENATE 'this is 2' lv_value lv_index INTO ls_dimension-description SEPARATED BY space.
      CONCATENATE '2' lv_value lv_index 'custom field' INTO ls_dimension-customfield_text1.

      APPEND ls_dimension TO es_dimensions-dimensions.
    ENDLOOP.
  ENDDO.
ENDMETHOD.
