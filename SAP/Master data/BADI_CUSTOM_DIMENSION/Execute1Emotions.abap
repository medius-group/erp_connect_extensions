METHOD /medius/if_badi_custom_dimensi~execute1.
  DATA:
    lv_comp_code         TYPE bukrs,
    ls_dimension         TYPE /medius/scustom_dimension,
    lv_index             TYPE string,
    lv_records_to_return TYPE i,
    lv_string            TYPE string,
    lt_strings           TYPE TABLE OF string.

  IF ic_id EQ 'Hangry'.
    ls_dimension-is_active = abap_true.
    ls_dimension-value = ic_id.
    ls_dimension-description = 'When no food becomes bad mood.'.

    LOOP AT it_comp_code
    INTO lv_comp_code.
      ls_dimension-comp_code = lv_comp_code.

      APPEND ls_dimension TO es_dimensions-dimensions.
    ENDLOOP.

    EXIT.
  ENDIF.

  APPEND 'Acceptance' TO lt_strings.
  APPEND 'Aching' TO lt_strings.
  APPEND 'Adoration' TO lt_strings.
  APPEND 'Affection' TO lt_strings.
  APPEND 'Aggressive' TO lt_strings.
  APPEND 'Agony' TO lt_strings.
  APPEND 'Alienated' TO lt_strings.
  APPEND 'Alone' TO lt_strings.
  APPEND 'Amazed' TO lt_strings.
  APPEND 'Amusement' TO lt_strings.
  APPEND 'Anger' TO lt_strings.
  APPEND 'Animosity' TO lt_strings.
  APPEND 'Annoyed' TO lt_strings.
  APPEND 'Anxious' TO lt_strings.
  APPEND 'Apathetic' TO lt_strings.
  APPEND 'Apologetic' TO lt_strings.
  APPEND 'Appreciative' TO lt_strings.
  APPEND 'Aware' TO lt_strings.
  APPEND 'Awe' TO lt_strings.
  APPEND 'Awkward' TO lt_strings.
  APPEND 'Baffled' TO lt_strings.
  APPEND 'Bitter' TO lt_strings.
  APPEND 'Boredom' TO lt_strings.
  APPEND 'Calm' TO lt_strings.
  APPEND 'Carefree' TO lt_strings.
  APPEND 'Cautious' TO lt_strings.
  APPEND 'Challenged' TO lt_strings.
  APPEND 'Cheated' TO lt_strings.
  APPEND 'Cheerful' TO lt_strings.
  APPEND 'Cold' TO lt_strings.
  APPEND 'Comfortable' TO lt_strings.
  APPEND 'Compassion' TO lt_strings.
  APPEND 'Confident' TO lt_strings.
  APPEND 'Confused' TO lt_strings.
  APPEND 'Contentment' TO lt_strings.
  APPEND 'Courageous' TO lt_strings.
  APPEND 'Cowardly' TO lt_strings.
  APPEND 'Cranky' TO lt_strings.
  APPEND 'Craving' TO lt_strings.
  APPEND 'Cruel' TO lt_strings.
  APPEND 'Curious' TO lt_strings.
  APPEND 'Defeated' TO lt_strings.
  APPEND 'Defensive' TO lt_strings.
  APPEND 'Delirious' TO lt_strings.
  APPEND 'Denial' TO lt_strings.
  APPEND 'Depressed' TO lt_strings.
  APPEND 'Desire' TO lt_strings.
  APPEND 'Desperate' TO lt_strings.
  APPEND 'Destructive' TO lt_strings.
  APPEND 'Determined' TO lt_strings.
  APPEND 'Disappointed' TO lt_strings.
  APPEND 'Disapproval' TO lt_strings.
  APPEND 'Disgust' TO lt_strings.
  APPEND 'Dislike' TO lt_strings.
  APPEND 'Dismay' TO lt_strings.
  APPEND 'Distracted' TO lt_strings.
  APPEND 'Distress' TO lt_strings.
  APPEND 'Doubtful' TO lt_strings.
  APPEND 'Eager' TO lt_strings.
  APPEND 'Embarrassed' TO lt_strings.
  APPEND 'Empathetic' TO lt_strings.
  APPEND 'Emptiness' TO lt_strings.
  APPEND 'Enchanted' TO lt_strings.
  APPEND 'Envy' TO lt_strings.
  APPEND 'Excitement' TO lt_strings.
  APPEND 'Fascinated' TO lt_strings.
  APPEND 'Fearful' TO lt_strings.
  APPEND 'Focused' TO lt_strings.
  APPEND 'Fraud (feeling like a)' TO lt_strings.
  APPEND 'Frazzled' TO lt_strings.
  APPEND 'Free' TO lt_strings.
  APPEND 'Friendly' TO lt_strings.
  APPEND 'Frustrated' TO lt_strings.
  APPEND 'Funny' TO lt_strings.
  APPEND 'Gladsomeness' TO lt_strings.
  APPEND 'Gloomy' TO lt_strings.
  APPEND 'Glum' TO lt_strings.
  APPEND 'Goofy' TO lt_strings.
  APPEND 'Grateful' TO lt_strings.
  APPEND 'Grieved' TO lt_strings.
  APPEND 'Guilt' TO lt_strings.
  APPEND 'Happiness' TO lt_strings.
  APPEND 'Hatred' TO lt_strings.
  APPEND 'Heartbroken' TO lt_strings.
  APPEND 'Hopeful' TO lt_strings.
  APPEND 'Hopeless' TO lt_strings.
  APPEND 'Horrified' TO lt_strings.
  APPEND 'Horror' TO lt_strings.
  APPEND 'Humble' TO lt_strings.
  APPEND 'Hurting' TO lt_strings.
  APPEND 'Hysteria' TO lt_strings.
  APPEND 'Impatient' TO lt_strings.
  APPEND 'Infuriated' TO lt_strings.
  APPEND 'Insecure' TO lt_strings.
  APPEND 'Inspired' TO lt_strings.
  APPEND 'Insulted' TO lt_strings.
  APPEND 'Jealous' TO lt_strings.
  APPEND 'Joy' TO lt_strings.
  APPEND 'Kind' TO lt_strings.
  APPEND 'Lazy' TO lt_strings.
  APPEND 'Left out' TO lt_strings.
  APPEND 'Loathe' TO lt_strings.
  APPEND 'Lonely' TO lt_strings.
  APPEND 'Lost' TO lt_strings.
  APPEND 'Love' TO lt_strings.
  APPEND 'Lovesick' TO lt_strings.
  APPEND 'Loyal' TO lt_strings.
  APPEND 'Lust' TO lt_strings.
  APPEND 'Mean' TO lt_strings.
  APPEND 'Melancholy' TO lt_strings.
  APPEND 'Miserable' TO lt_strings.
  APPEND 'Misery' TO lt_strings.
  APPEND 'Needy' TO lt_strings.
  APPEND 'Nervous' TO lt_strings.
  APPEND 'Nostalgia' TO lt_strings.
  APPEND 'Obsessed' TO lt_strings.
  APPEND 'Offended' TO lt_strings.
  APPEND 'Optimistic' TO lt_strings.
  APPEND 'Outrage' TO lt_strings.
  APPEND 'Overwhelmed' TO lt_strings.
  APPEND 'Panicked' TO lt_strings.
  APPEND 'Paranoid' TO lt_strings.
  APPEND 'Patient' TO lt_strings.
  APPEND 'Peace' TO lt_strings.
  APPEND 'Pensive' TO lt_strings.
  APPEND 'Pessimistic' TO lt_strings.
  APPEND 'Pity' TO lt_strings.
  APPEND 'Pride' TO lt_strings.
  APPEND 'Protective' TO lt_strings.
  APPEND 'Proud' TO lt_strings.
  APPEND 'Rage' TO lt_strings.
  APPEND 'Relief' TO lt_strings.
  APPEND 'Reluctant' TO lt_strings.
  APPEND 'Remorse' TO lt_strings.
  APPEND 'Resentful' TO lt_strings.
  APPEND 'Resentment' TO lt_strings.
  APPEND 'Resigned' TO lt_strings.
  APPEND 'Romantic' TO lt_strings.
  APPEND 'Sadness' TO lt_strings.
  APPEND 'Satisfaction' TO lt_strings.
  APPEND 'Self-pity' TO lt_strings.
  APPEND 'Sensual' TO lt_strings.
  APPEND 'Sentimental' TO lt_strings.
  APPEND 'Sexy' TO lt_strings.
  APPEND 'Shock' TO lt_strings.
  APPEND 'Shy' TO lt_strings.
  APPEND 'Skeptical' TO lt_strings.
  APPEND 'Sorrow' TO lt_strings.
  APPEND 'Spite' TO lt_strings.
  APPEND 'Stressed' TO lt_strings.
  APPEND 'Submissive' TO lt_strings.
  APPEND 'Sulkiness' TO lt_strings.
  APPEND 'Surprised' TO lt_strings.
  APPEND 'Suspicious' TO lt_strings.
  APPEND 'Sweet' TO lt_strings.
  APPEND 'Tender' TO lt_strings.
  APPEND 'Tense' TO lt_strings.
  APPEND 'Terrified' TO lt_strings.
  APPEND 'Tired' TO lt_strings.
  APPEND 'Troubled' TO lt_strings.
  APPEND 'Umpty' TO lt_strings.
  APPEND 'Uncomfortable' TO lt_strings.
  APPEND 'Understanding' TO lt_strings.
  APPEND 'Uneasy' TO lt_strings.
  APPEND 'Unhappy' TO lt_strings.
  APPEND 'Vengeful' TO lt_strings.
  APPEND 'Vigilant' TO lt_strings.
  APPEND 'Vulnerable' TO lt_strings.
  APPEND 'Wanderlust' TO lt_strings.
  APPEND 'Warm' TO lt_strings.
  APPEND 'Withdrawal' TO lt_strings.
  APPEND 'Wonder' TO lt_strings.
  APPEND 'Worn out' TO lt_strings.
  APPEND 'Worried' TO lt_strings.
  APPEND 'Wrath' TO lt_strings.
  APPEND 'Yearning' TO lt_strings.

  LOOP AT lt_strings INTO lv_string FROM ii_offset + 1.
    lv_index = sy-tabix - ii_offset.

    IF lv_index GT ii_number_of_records.
      EXIT.
    ENDIF.

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

      ls_dimension-value = lv_string.
      CONCATENATE 'What is ' lv_string '?' INTO ls_dimension-description RESPECTING BLANKS.

      APPEND ls_dimension TO es_dimensions-dimensions.
    ENDLOOP.
  ENDLOOP.
ENDMETHOD.
