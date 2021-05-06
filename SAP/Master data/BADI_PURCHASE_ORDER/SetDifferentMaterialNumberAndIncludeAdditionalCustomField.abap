  METHOD /medius/if_badi_purchase_order~post_processing.
    DATA lc_po TYPE /medius/spurchase_order.
    FIELD-SYMBOLS:
      <ls_med_item> TYPE /medius/spo_item,
      <ls_med_po>   TYPE /medius/spurchase_order.
    TYPES: BEGIN OF y_material,
             matnr TYPE matnr,
             ekgrp TYPE ekgrp,
             prctr TYPE prctr,
             eknam TYPE eknam,
           END OF y_material.

    DATA: ls_material TYPE y_material.

    LOOP AT ct_purchase_order ASSIGNING <ls_med_po>.
      LOOP AT <ls_med_po>-po_items ASSIGNING <ls_med_item>.
        SELECT SINGLE bednr, zzload, werks, lgort
          INTO @DATA(ls)
           FROM ekpo
             WHERE ebeln = @<ls_med_po>-po_number AND
                   ebelp = @<ls_med_item>-po_item.
        IF sy-subrc = 0.
          IF ls-zzload IS NOT INITIAL.
            <ls_med_item>-material = ls-zzload.
          ELSEIF ls-bednr IS NOT INITIAL.
            <ls_med_item>-material = ls-bednr.
          ENDIF.
          IF ls-lgort IS NOT INITIAL.
            CONCATENATE ls-werks '-' ls-lgort
               INTO <ls_med_item>-requistioner.
          ELSEIF ls-werks IS NOT INITIAL.
            <ls_med_item>-requistioner = ls-werks.
          ENDIF.

        ENDIF.
        SELECT single sakto INTO @DATA(lv_sakto)
           FROM ekkn
             WHERE ebeln = @<ls_med_po>-po_number AND
                   ebelp = @<ls_med_item>-po_item.
          IF sy-subrc = 0.
            <ls_med_item>-customfield_text3 = lv_sakto.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDMETHOD.