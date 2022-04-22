METHOD /medius/if_badi_supplier~post_processing.

    *Remove vendors where LFA1-KTOKK = ZCON
    
    DATA: lt_lfa1 TYPE STANDARD TABLE OF lfa1
    ,lt_supplier TYPE /medius/lsupplier
    .
    
    FIELD-SYMBOLS <zzct_supplier> TYPE /medius/ssupplier.
    
    IF lines( ct_supplier ) > 0.
    
    *Find all vendor there has to be removed
    SELECT lifnr INTO CORRESPONDING FIELDS OF TABLE lt_lfa1
    FROM lfa1
    FOR ALL ENTRIES IN ct_supplier
    WHERE lifnr = ct_supplier-vendor_no
    AND ktokk = 'ZCON'
    ORDER BY PRIMARY KEY.
    
    LOOP AT ct_supplier ASSIGNING <zzct_supplier>.
    *Mark all entry there has to be removed
    READ TABLE lt_lfa1 TRANSPORTING NO FIELDS
    WITH KEY lifnr = <zzct_supplier>-vendor_no
    BINARY SEARCH.
    IF sy-subrc = 0.
                <zzct_supplier>-vendor_no = 'ZZZZZZZZZZ'.
    ENDIF.
    ENDLOOP.
    
    *delete vendor there has to be removed
    DELETE ct_supplier WHERE vendor_no = 'ZZZZZZZZZZ'.
    
    ENDIF.
    
    ENDMETHOD.