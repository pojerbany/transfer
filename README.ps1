New Column = 
VAR CleanNumber = 
    CALCULATE(
        SELECTEDVALUE(
            PATHITEM(
                SUBSTITUTE(
                    VALUES('Table'[Y]),
                    "-",
                    " "
                ),
                4
            )
        )
    )
RETURN
    IF(
        ISNUMBER(CleanNumber),
        CleanNumber,
        BLANK()
    )
