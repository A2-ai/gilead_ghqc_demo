pkdf5 <- pkdf4 |>
  mutate(
    C = ifelse(ATFD < 0 & EVID == 0, "C", NA),
    LINE = row_number(),
    ID = match(USUBJID, unique(USUBJID)),
    DV = ifelse(DV == 0, NA, DV),
    LDV = round(log(DV), 3),
    MDV = ifelse(is.na(DV), 1, 0),
    BLQ = case_when(EVID == 1 ~ 0,
                    EVID == 0 & !is.na(DV) ~ 0,
                    EVID == 0 & ATFD < 0 & is.na(DV) ~ 2,
                    EVID == 0 & ATFD > 0 & is.na(DV) ~ 1),
    LLOQ = NA,
    STUDY = "STUDY-NAME-CHANGED",
    IMPDOS = 0,
    DOSEA = AMT[first(which(EVID == 1))],
    CFLAG = 100
  ) %>%
  select(C, LINE, ID, NTFD, NTLD, NTFD, NTLD, TEST, AMT, DV, LDV, EVID, CMT, MDV, BLQ, LLOQ, DOSEA, IMPDOS, STUDY, USUBJID, DTIM, FDOSE, VISIT, TPT, CFLAG)
write.csv(pkdf5, file.path(derDir, "PK_AXAN101.csv"), na = ".")

select(C, LINE, ID, ATFD, ATLD, NTFD, NTLD, TEST, AMT, DV, LDV, EVID, CMT, MDV, BLQ, LLOQ, DOSEA, IMPDOS, STUDY, USUBJID, DTIM, FDOSE, VISIT, TPT, CFLAG)
write.csv(pkdf5, file.path(derDir, "PK_AXAN101.csv"), na = ".")
