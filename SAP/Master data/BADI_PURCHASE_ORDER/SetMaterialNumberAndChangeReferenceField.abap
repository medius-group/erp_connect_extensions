 method /MEDIUS/IF_BADI_PURCHASE_ORDER~POST_PROCESSING.

    DATA: lc_po TYPE /medius/spurchase_order.

    FIELD-SYMBOLS:
      <ls_med_item> TYPE /medius/spo_item,
      <ls_med_po>   TYPE /medius/spurchase_order.

    TYPES: BEGIN OF t_afnam,
             afnam TYPE afnam,
           END OF t_afnam.

    DATA: ws_afnam  TYPE t_afnam,
          wt_afnam  TYPE TABLE OF t_afnam,
          im_header TYPE REF TO if_purchase_order_mm,
          ls_header TYPE mepoheader,
          lt_items  TYPE purchase_order_items,
          ls_items  TYPE purchase_order_item,
          ls_item   TYPE mepoitem,
          lv_lines  TYPE i,
          lv_doc_type TYPE esart.

clear: lv_doc_type.

   LOOP at ct_purchase_order ASSIGNING <ls_med_po>.

       lv_doc_type = <ls_med_po>-doc_type.
       
      LOOP at <ls_med_po>-po_items ASSIGNING <ls_med_item>.

           ws_afnam-afnam = <ls_med_item>-requistioner.
           APPEND ws_afnam to wt_afnam.
           clear: ws_afnam.

         if lv_doc_type = 'Y002' and <ls_med_item>-item_cat = '0'.
           if <ls_med_item>-vendor_material is NOT INITIAL.
              <ls_med_item>-material = <ls_med_item>-vendor_material.
           else.
              <ls_med_item>-material = 'EMPTY'.
           ENDIF.
         endif.

      ENDLOOP.

      if wt_afnam is NOT INITIAL.
        SORT wt_afnam by afnam ASCENDING.
        DELETE ADJACENT DUPLICATES FROM wt_afnam COMPARING afnam.

        DESCRIBE TABLE wt_afnam lines lv_lines.

        if lv_lines = 1.

           READ TABLE wt_afnam INTO ws_afnam INDEX 1.
             if sy-subrc = 0.
                <ls_med_po>-purch_group_name = ws_afnam-afnam.
             endif.
        endif.
      endif.

      clear: lv_doc_type, lv_lines.
      refresh : wt_afnam[].

    ENDLOOP.

  endmethod.