*-----------------
* File: simple_pdf.f
*-----------------
*
* Simple built-in PDF parameterization for 64-bit builds when LHAPDF is not available
* This provides a basic Leading Order PDF similar to CTEQ6L1
* Based on simple valence + sea parameterizations
*

      SUBROUTINE SIMPLEPDF_GETPDFS(X, Q, UPV, DNV, USEA, DSEA, STR, 
     &                              CHM, BOT, TOP, GL)
*     Get PDFs using built-in simple parameterization
*     This is a basic approximation for when LHAPDF is not available
      
      IMPLICIT NONE
      DOUBLE PRECISION X, Q
      DOUBLE PRECISION UPV, DNV, USEA, DSEA, STR, CHM, BOT, TOP, GL
      
*     Local variables
      DOUBLE PRECISION QREF, LAMBDA, T, ALPHAS, QUSE
      DOUBLE PRECISION AU, BU, CU, DU, AD, BD, CD, DD
      DOUBLE PRECISION ASEA, BSEA, CSEA, AGLU, BGLU, CGLU
      DOUBLE PRECISION XUPV, XDNV, XSEA, XGLU
      DOUBLE PRECISION PI
      PARAMETER (PI = 3.14159265358979323846D0)
      
*     Reference scale and Lambda_QCD
      PARAMETER (QREF = 2.0D0, LAMBDA = 0.220D0)
      
*     Check for valid x and Q
      IF (X .LE. 0.0D0 .OR. X .GE. 1.0D0) THEN
         UPV = 0.0D0
         DNV = 0.0D0
         USEA = 0.0D0
         DSEA = 0.0D0
         STR = 0.0D0
         CHM = 0.0D0
         BOT = 0.0D0
         TOP = 0.0D0
         GL = 0.0D0
         RETURN
      ENDIF
      
*     Use local variable to avoid modifying input parameter
      QUSE = Q
      IF (QUSE .LT. LAMBDA) THEN
         QUSE = LAMBDA
      ENDIF
      
*     Simple LO evolution parameter
      T = LOG(LOG(QUSE**2 / LAMBDA**2) / LOG(QREF**2 / LAMBDA**2))
      
*     Valence quark parameterizations
*     u valence: roughly 2:1 ratio to d valence
*     Parameters tuned to approximate CTEQ6L1 at Q=2 GeV
      AU = 2.7D0 * (1.0D0 + 0.2D0 * T)
      BU = 0.55D0 + 0.05D0 * T
      CU = 4.0D0 - 0.3D0 * T
      DU = 1.0D0
      XUPV = AU * X**BU * (1.0D0 - X)**CU * (1.0D0 + DU * SQRT(X))
      
      AD = 1.3D0 * (1.0D0 + 0.2D0 * T)
      BD = 0.55D0 + 0.05D0 * T
      CD = 5.0D0 - 0.3D0 * T
      DD = 1.0D0
      XDNV = AD * X**BD * (1.0D0 - X)**CD * (1.0D0 + DD * SQRT(X))
      
*     Sea quark parameterizations (flavor symmetric at LO)
      ASEA = 1.5D0 * (1.0D0 + 0.3D0 * T)
      BSEA = -0.15D0
      CSEA = 7.0D0 - 0.5D0 * T
      XSEA = ASEA * X**BSEA * (1.0D0 - X)**CSEA
      
*     Gluon parameterization
      AGLU = 2.5D0 * (1.0D0 - 0.2D0 * T)
      BGLU = -0.20D0
      CGLU = 5.5D0 + 0.3D0 * T
      XGLU = AGLU * X**BGLU * (1.0D0 - X)**CGLU
      
*     Convert x*f(x) to f(x)
      UPV = XUPV / X
      DNV = XDNV / X
      USEA = XSEA / X
      DSEA = XSEA / X
      
*     Strange sea (slightly suppressed)
      STR = 0.5D0 * XSEA / X
      
*     Heavy flavors (charm threshold at ~1.5 GeV)
      IF (QUSE .GT. 1.5D0) THEN
         CHM = 0.05D0 * XSEA / X
      ELSE
         CHM = 0.0D0
      ENDIF
      
*     Bottom (threshold at ~4.5 GeV)
      IF (QUSE .GT. 4.5D0) THEN
         BOT = 0.01D0 * XSEA / X
      ELSE
         BOT = 0.0D0
      ENDIF
      
*     Top (threshold at ~175 GeV, but negligible in proton)
      TOP = 0.0D0
      
*     Gluon
      GL = XGLU / X
      
      END SUBROUTINE SIMPLEPDF_GETPDFS
