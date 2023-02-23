  METHOD /medius/if_badi_purchase_order~post_processing.
    " A purchase order with a reference to an internal order will not be
    " imported if the given internal order is not in Medius.
    " 
    " If internal order pre-coding is not utilized, this reference can be
    " removed to allow such an order to be imported.

    DATA:
      ls_med_po TYPE /medius/spurchase_order,
      ls_med_po_item TYPE /medius/spo_item,
      ls_med_gr TYPE /medius/sgoods_receipt,
      ls_account_assignment TYPE /MEDIUS/SPO_ACCOUNT_ASSIGNMENT,
      lb_update TYPE abap_bool.

    LOOP AT ct_purchase_order INTO ls_med_po.
      lb_update = abap_false.

      LOOP AT ls_med_po-po_items INTO ls_med_po_item.
        LOOP AT ls_med_po_item-account_assignments
        INTO ls_account_assignment
        WHERE internal_order IS NOT INITIAL.
          CLEAR ls_account_assignment-internal_order.

          MODIFY ls_med_po_item-account_assignments FROM ls_account_assignment INDEX sy-tabix.
          lb_update = abap_true.
        ENDLOOP.

        IF lb_update EQ abap_true.
          MODIFY ls_med_po-po_items FROM ls_med_po_item INDEX sy-tabix.
        ENDIF.
      ENDLOOP.

      IF lb_update EQ abap_true.
        MODIFY ct_purchase_order FROM ls_med_po INDEX sy-tabix.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
