METHOD /medius/if_badi_custom_dimensi~execute2.
  DATA:
    ls_dimension         TYPE /medius/scustom_dimension,
    lv_comp_code         TYPE bukrs,
    lv_index             TYPE string,
    lv_records_to_return TYPE i,
    lv_value             TYPE string.

  " This contrived example returns generated bogus records.
  " Here, available features are demonstrated but don't make much sense in the real world.
  " Other Medius master data processes retrieving dimension values can be used for reference. E.g GL_ACCOUNT, COST_CENTER, WBS_ELEMENTS, etc.

  " Pagination is required to be implemented.
  " This is a contrived example. In real life, it will reflect the data. SQL queries must include OFFSET and NUMBER_OF_RECORDS parameters.
  IF ii_offset EQ 0. " When asking for first page, return a full page. If a full page is returned, HAS_MORE is set to true and the next page will be asked for.
    lv_records_to_return = ii_number_of_records.
  ELSEIF ii_offset EQ ii_number_of_records. " When asking for subsequent pages, return half a page.
    lv_records_to_return = ii_number_of_records / 2.
  ENDIF.

  lv_value = 'foo'. " Just arbitrary text. This is the real dimension value.

  IF ic_language EQ 'V'. " Has language support. 'V' is Swedish in SAP code. Note that the HTTP interface utilizes ISO codes ('SV' in this case).
    lv_value = 'föö'.
  ENDIF.

  DO lv_records_to_return TIMES. " In the real world, this reflects the result set from the actual data retrieved.
    lv_index = sy-index. " Concatenated with lv_value to generate unique records.

    LOOP AT it_comp_code " Add records for all requested companies. Usually, dimension values are not tied to a specific company. So, we just add it for all companies asked for.
    INTO lv_comp_code.
      ls_dimension-comp_code = lv_comp_code. " Used for external system ID in Medius.
      ls_dimension-is_active = abap_true. " If the record is to be active or not in Medius.

      IF lv_index EQ 2.
        ls_dimension-is_active = abap_false. " Arbitrarily set the second record of each page to inactive. Just for demonstration.
      ENDIF.

      IF NOT ic_mode EQ /medius/if=>c_mode_changes_and_expiring " Arbitrarily treat the third record of each page as it was only retrieved by expired schedule. This runs (attow.) 4 times per day by default.
        AND lv_index EQ 3.
        CONTINUE.
        " Normally, this is utilized for heavy operations that are not feasible to run every 5th minute or cases where best-practice delta retieval is not possible/feasible.
      ENDIF.

      IF ic_mode EQ /medius/if=>c_mode_all_entries " For initial load, filter out inactive records as they are not relevant in APA.
        AND ls_dimension-is_active EQ abap_false.
        CONTINUE.
      ENDIF.

      CONCATENATE '2' lv_value lv_index INTO ls_dimension-value. " Value is the dimension value itself.
      CONCATENATE 'this is 2' lv_value lv_index INTO ls_dimension-description SEPARATED BY space. " A description for the dimension value.
      CONCATENATE '2' lv_value lv_index 'custom field' INTO ls_dimension-customfield_text1. " Custom fields are supported.

      APPEND ls_dimension TO es_dimensions-dimensions. " Add the record to be exported.
    ENDLOOP.
  ENDDO.
ENDMETHOD.
