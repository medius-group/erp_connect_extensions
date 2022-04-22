METHOD /medius/if_badi_fi_invoice~execute_post.

    *
    * Example that shows how to pass additional local currency lines for customized rate types
    *

    DATA: lt_bapi_currencyamount TYPE /medius/lbapiaccr09,
              ls_bapi_currencyamount LIKE LINE OF lt_bapi_currencyamount,
              ls_bapi_currencytransf LIKE LINE OF lt_bapi_currencyamount,
              lv_date                TYPE d,
              lv_wrbtr_in            TYPE wrbtr,
              lv_wrbtr_tr            TYPE wrbtr,
              lv_diff                TYPE bapidoccur,
              ls_bapi_accountgl      LIKE LINE OF ct_bapi_accountgl,
              ls_bapi_accounttax     LIKE LINE OF ct_bapi_accounttax.
    
    FIELD-SYMBOLS <fs_bapi_currencyamount> LIKE LINE OF lt_bapi_currencyamount.

    IF is_header-comp_code EQ 'XXXX'.
          lt_bapi_currencyamount = ct_bapi_currencyamount.
    IF is_header-doc_date IS NOT INITIAL.
            lv_date = is_header-doc_date.
    ELSEIF is_header-pstng_date IS NOT INITIAL.
            lv_date = is_header-pstng_date.
    ELSE.
            lv_date = sy-datum.
    ENDIF.
    
    LOOP AT lt_bapi_currencyamount INTO ls_bapi_currencyamount.
    IF ls_bapi_currencyamount-currency NE 'EURH'.
              ls_bapi_currencytransf = ls_bapi_currencyamount.
              lv_wrbtr_in = ls_bapi_currencyamount-amt_doccur.
              ls_bapi_currencytransf-curr_type = '10'.
              ls_bapi_currencytransf-currency = 'EURH'.
    
    CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
    EXPORTING
    date             = lv_date
                  foreign_amount   = lv_wrbtr_in
    *             foreign_amount   = ls_bapi_currencyamount-amt_doccur
                  foreign_currency = ls_bapi_currencyamount-currency
                  local_currency   = ls_bapi_currencytransf-currency
    *             RATE             = 0
    *             TYPE_OF_RATE     = 'M'
    *             READ_TCURR       = 'X'
    IMPORTING
    *             EXCHANGE_RATE    = EXCHANGE_RATE
    *             FOREIGN_FACTOR   = FOREIGN_FACTOR
    *             local_amount     = ls_bapi_currencytransf-amt_doccur
                  local_amount     = lv_wrbtr_tr
    *             LOCAL_FACTOR     = LOCAL_FACTOR
    *             EXCHANGE_RATEX   = EXCHANGE_RATEX
    *             FIXED_RATE       = FIXED_RATE
    *             DERIVED_RATE_TYPE       = DERIVED_RATE_TYPE
    EXCEPTIONS
                  no_rate_found    = 1
                  overflow         = 2
                  no_factors_found = 3
                  no_spread_found  = 4
                  derived_2_times  = 5
    OTHERS           = 6.
    IF sy-subrc <> 0.
        * Implement suitable error handling here
        ELSE.
                    ls_bapi_currencytransf-amt_doccur = lv_wrbtr_tr.
        
        IF ls_bapi_currencyamount-amt_base IS NOT INITIAL.
                      lv_wrbtr_in = ls_bapi_currencyamount-amt_base.
        CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
        date             = lv_date
                          foreign_amount   = lv_wrbtr_in
                          foreign_currency = ls_bapi_currencyamount-currency
                          local_currency   = ls_bapi_currencytransf-currency
        IMPORTING
                          local_amount     = lv_wrbtr_tr
        EXCEPTIONS
                          no_rate_found    = 1
                          overflow         = 2
                          no_factors_found = 3
                          no_spread_found  = 4
                          derived_2_times  = 5
        OTHERS           = 6.
        IF sy-subrc IS INITIAL.
                        ls_bapi_currencytransf-amt_base = lv_wrbtr_tr.
        ENDIF.
        ENDIF.
        
        IF ls_bapi_currencyamount-disc_base IS NOT INITIAL.
                      lv_wrbtr_in = ls_bapi_currencyamount-disc_base.
        CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
        date             = lv_date
                          foreign_amount   = lv_wrbtr_in
                          foreign_currency = ls_bapi_currencyamount-currency
                          local_currency   = ls_bapi_currencytransf-currency
        IMPORTING
                          local_amount     = lv_wrbtr_tr
        EXCEPTIONS
                          no_rate_found    = 1
                          overflow         = 2
                          no_factors_found = 3
                          no_spread_found  = 4
                          derived_2_times  = 5
        OTHERS           = 6.
        IF sy-subrc IS INITIAL.
                        ls_bapi_currencytransf-disc_base = lv_wrbtr_tr.
        ENDIF.
        ENDIF.
        IF ls_bapi_currencyamount-disc_amt IS NOT INITIAL.
            lv_wrbtr_in = ls_bapi_currencyamount-disc_amt.
        CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
        date             = lv_date
                        foreign_amount   = lv_wrbtr_in
                        foreign_currency = ls_bapi_currencyamount-currency
                        local_currency   = ls_bapi_currencytransf-currency
        IMPORTING
                        local_amount     = lv_wrbtr_tr
        EXCEPTIONS
                        no_rate_found    = 1
                        overflow         = 2
                        no_factors_found = 3
                        no_spread_found  = 4
                        derived_2_times  = 5
        OTHERS           = 6.
        IF sy-subrc IS INITIAL.
                    ls_bapi_currencytransf-disc_amt = lv_wrbtr_tr.
        ENDIF.
        ENDIF.

        IF ls_bapi_currencyamount-tax_amt IS NOT INITIAL.
                    lv_wrbtr_in = ls_bapi_currencyamount-tax_amt.
        CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
        date             = lv_date
                        foreign_amount   = lv_wrbtr_in
                        foreign_currency = ls_bapi_currencyamount-currency
                        local_currency   = ls_bapi_currencytransf-currency
        IMPORTING
                        local_amount     = lv_wrbtr_tr
        EXCEPTIONS
                        no_rate_found    = 1
                        overflow         = 2
                        no_factors_found = 3
                        no_spread_found  = 4
                        derived_2_times  = 5
        OTHERS           = 6.
        IF sy-subrc IS INITIAL.
                    ls_bapi_currencytransf-tax_amt = lv_wrbtr_tr.
        ENDIF.
        ENDIF.

        APPEND ls_bapi_currencytransf TO ct_bapi_currencyamount.
        ENDIF.

        ENDIF.
        ENDLOOP.

        CLEAR: lv_diff, ls_bapi_accountgl, ls_bapi_accounttax.
        LOOP AT ct_bapi_currencyamount ASSIGNING <fs_bapi_currencyamount> WHERE curr_type = '10'
        AND currency = 'EURH'.
            lv_diff = lv_diff + <fs_bapi_currencyamount>-amt_doccur.
        ENDLOOP.

        IF lv_diff IS NOT INITIAL.
        SORT ct_bapi_currencyamount BY curr_type DESCENDING itemno_acc DESCENDING.
        LOOP AT ct_bapi_currencyamount ASSIGNING <fs_bapi_currencyamount> WHERE curr_type = '10'
        AND currency = 'EURH'.

        READ TABLE ct_bapi_accountgl INTO ls_bapi_accountgl WITH KEY itemno_acc = <fs_bapi_currencyamount>-itemno_acc.
        IF sy-subrc IS INITIAL.
                <fs_bapi_currencyamount>-amt_doccur = <fs_bapi_currencyamount>-amt_doccur - lv_diff.
        EXIT.
        ENDIF.
        ENDLOOP.

        LOOP AT ct_bapi_currencyamount ASSIGNING <fs_bapi_currencyamount> WHERE curr_type = '10'
        AND currency = 'EURH'.

        READ TABLE ct_bapi_accounttax INTO ls_bapi_accounttax WITH KEY itemno_acc = <fs_bapi_currencyamount>-itemno_acc
                                                                            tax_code = ls_bapi_accountgl-tax_code.
        IF sy-subrc IS INITIAL.
                <fs_bapi_currencyamount>-amt_base = <fs_bapi_currencyamount>-amt_base - lv_diff.
        EXIT.
        ENDIF.
        ENDLOOP.
        ENDIF.

        SORT ct_bapi_currencyamount BY curr_type DESCENDING itemno_acc ASCENDING.

        ENDIF.

ENDMETHOD.  